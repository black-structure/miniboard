module BoardHelper
  def board_thread_number
    if(defined? @thrd)
      @thrd.number.to_s
    else
      ''
    end
  end
  
  def board_post_url(post)
    board_thread_url(thrd: post.thrd) + '#' + post.number.to_s
  end
  
  def board_post_url_i(post)
    board_thread_url(thrd: post.thrd) + '#i' + post.number.to_s
  end

  def board_form_url(opts={})
    board = (opts.include? :board) ? opts[:board] : @board

    if(!defined? @thrd)
      "/boards/#{board.name}/new"
    else
      "/boards/#{board.name}/#{@thrd.number}/new"
    end
  end
end
