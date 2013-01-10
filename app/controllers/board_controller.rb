class BoardController < ApplicationController
  before_filter :init_board
  before_filter :init_thrd, :only => [:thread, :post, :new_post]
  
  def init_board
    @board = Board.where(name: params[:board]).first
  end

  def init_thrd
    @thrd = @board.thrds.where(number: params[:thrd]).first
    raise "thread `#{params[:thrd]}` not found" unless @thrd
  end
  
  public
  
  # controllers
  
  def index
    @post = Post.new(empty: true)
    
    @pager = ::Paginator.new(@board.thrds.length, @board.perpage) do |offset, perpage|
      nodes = {}
      @board.thrds.desc(:last_time).skip(offset).limit(perpage).each do |thrd|
        posts = thrd.posts.desc(:number)
        first = posts.last
        count = thrd.count
        replies = posts.limit(@board.replies_on_index).to_a.reverse.drop_while{|post| post==first}
        omitted = count - replies.length - 1
        omitted_files = thrd.count_files - replies.count{ |post| post.file? } - (first.file? ? 1 : 0)

        nodes[thrd.number] = {
          first: first,
          omitted: omitted,
          omitted_files: omitted_files,
          replies: replies 
          }
      end
      nodes
    end
    
    page_number = params[:page]

    @page = @pager.page(page_number)
    
    respond_to do |format|
      format.html
      format.json do
        render json: {
                        board: @board.name,
                        page: page_number,
                        perpage: @board.perpage,
                        nodes: @page.items
                      }
      end
    end
  end

  def thread
    @post = Post.new(empty: true)
    
    @posts = @thrd.posts.asc(:number).collect{|x| x}
    @first = @posts.slice!(0)
    
    respond_to do |format|
      format.html
      format.json do
        render json: { 
                        board: @board.name,
                        thread: @thrd.number,
                        first: @first,
                        replies: @posts
                      }
      end
    end
  end

  def post
    @post = Post.where(board: @board, number: number).first
    respond_to do |format|
      format.json { render json: @post }
    end
  end
  
  def new_post
    hash = params[:post].clone
    hash[:number] = @board.inc_number!
    hash[:board] = @board
    hash[:thrd] = @thrd
    post = Post.create!(hash)
    if(!post.read_attribute(:sage))
      @thrd.bump!(post)
    end
    @thrd.update_counters!(post)
    
    respond_to do |format|
      format.html { redirect_to board_thread_url }
      format.json do
        render json: {
                        board: @board.name,
                        thread: @thrd.number,
                        post: post.number
                      }
      end
    end
  end
  
  def new_thread
    hash = params[:post].clone
    hash[:number] = @board.inc_number!
    hash[:board] = @board
    @post = Post.create!(hash)
    thrd = Thrd.create!(posts: [@post], board: @board, number: @post.number, count: 1, count_files: (@post.file? ? 1 : 0))
    @board.thrds << thrd
    thrd.bump!(@post)
    
    respond_to do |format|
      format.html { redirect_to board_index_url }
      format.json { render json: { board: @board.name, thread: @thrd.number } }
    end
  end

  def delete
    if params.include? :thrd
      @thrd = @board.thrds.where(number: params[:thrd]).first
    end

    deleted = []

    if params[:post_id]
      params[:post_id].each do |number|
        post = Post.where(board: @board, number: number).first
        if post && !post.password.empty? && post.password == params[:postpassword]
          post.destroy
          deleted << { board: @board.name, post: number }
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to @thrd ? board_thread_url : board_index_url }
      format.json { render json: deleted }
    end
  end
end
