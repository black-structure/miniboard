class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :board_index_url, :board_thread_url # some shared helpers
  
  protected
  
  def board_index_url(opts={})
    board = (opts.include? :board) ? opts[:board] : @board

    if(opts.include? :page)
      "/boards/#{board.name}/#{opts[:page]}"
    else
      "/boards/#{board.name}"
    end
  end
  
  def board_thread_url(opts={})
    board = (opts.include? :board) ? opts[:board] : @board

    if(opts.include? :thrd)
      "/boards/#{board.name}/#{opts[:thrd].number}"
    elsif(defined? @thrd)
      "/boards/#{board.name}/#{@thrd.number}"
    else
      # TODO: raise exception
      "/boards/#{board.name}"
    end
  end

end
