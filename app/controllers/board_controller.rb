class BoardController < ApplicationController
  
  
  helper_method :board_index_url, :board_thread_url
  before_filter :init_board
  
  # some shared helpers
  
  protected
  
  def board_index_url(opts={})
    if(opts.include? :page)
      "/#{@board.name}/#{opts[:page]}.html"
    else
      "/#{@board.name}"
    end
  end
  
  def board_thread_url(opts={})
    if(opts.include? :thrd)
      "/#{@board.name}/res/#{opts[:thrd].number}.html"
    elsif(defined? @thrd)
      "/#{@board.name}/res/#{@thrd.number}.html"
    else
      # TODO: raise exception
      "/#{@board.name}"
    end
  end
  
  def init_board
    @board = Board.first(conditions: {name: params[:board]})
  end
  
  public
  
  # controllers
  
  def index
    @post = Post.new
    
    @pager = ::Paginator.new(Thrd.count, @board.perpage) do |offset, per_page|
      nodes = {}
      Thrd.desc(:last_time).skip(offset).limit(per_page).each do |thrd|
        posts = thrd.posts.desc(:number)
        first = posts.last
        nodes[thrd.number] = {
          first: first,
          replies: posts.limit(5).collect{|x| x}.reverse.reject{|x| first.id==x.id}
          }
      end
      nodes
    end
    
    @page = @pager.page(params[:page])
    
    respond_to do |format|
      format.html
    end
    
  end

  def thread
    @post = Post.new
    
    @thrd = Thrd.first(conditions: { number: params[:thrd] })
    @posts = @thrd.posts.asc(:number).collect{|x| x}
    @first = @posts.slice!(0)
    
    respond_to do |format|
      format.html
    end
  end
  
  def new_post
    @thrd = Thrd.first(conditions: { number: params[:thrd] })
    
    fields = params[:post].clone
    fields[:number] = @board.inc_number
    fields[:board] = @board
    
    if(@thrd)
      post = Post.create!(fields)
      @thrd.posts << post
      if(!post.read_attribute(:sage))
        @thrd.bump!(post)
      end
    else
      raise "thread `#{params[:thrd]}` not found"
    end
    
    redirect_to board_thread_url
  end
  
  def new_thread
    fields = params[:post].clone
    fields[:number] = @board.inc_number
    fields[:board] = @board
    
    @post = Post.create!(fields)
    Thrd.create!(:posts => [@post], :board => @board, :number => @post.number) do |thrd|
      thrd.bump!(@post)
    end
    
    redirect_to board_index_url
  end
end
