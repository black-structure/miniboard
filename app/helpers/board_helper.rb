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
    board = opts[:board] || @board

    if(!defined? @thrd)
      "/boards/#{board.name}/new"
    else
      "/boards/#{board.name}/#{@thrd.number}/new"
    end
  end

  def board_delform_url(opts={})
    board = opts[:board] || @board

    if(!defined? @thrd)
      "/boards/#{board.name}/delete"
    else
      "/boards/#{board.name}/#{@thrd.number}/delete"
    end
  end

  def postername(post)
    name = if !post.postername.empty? then post.postername else post.board.postername_default end
    if post.sage then link_to(name, 'mailto:sage') else name end
  end
end
