class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :board_index_url, :board_thread_url, # some shared helpers
                :format_date, :format_filesize
  
  protected
  
  def board_index_url(opts={})
    board = (opts.include? :board) ? opts[:board] : @board

    if(opts.include? :page)
      "/boards/#{board.name}/page#{opts[:page]}"
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

  def format_date(date)
    date.to_s
  end


  def format_filesize(size)
    units = %w{B KB MB GB TB}
    e = (Math.log(size)/Math.log(1024)).floor
    s = "%.3f" % (size.to_f / 1024**e)
    s.sub(/\.?0*$/, units[e])
  end

end
