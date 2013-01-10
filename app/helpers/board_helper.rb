module BoardHelper
  def board_thread_number
    if @thrd
      @thrd.number.to_s
    else
      ''
    end
  end
  
  def board_reflink_url(post)
    board_thread_url(thrd: post.thrd) + '#' + post.number.to_s
  end
  
  def board_reflink_url_i(post)
    board_thread_url(thrd: post.thrd) + '#i' + post.number.to_s
  end

  def board_post_url(opts)
    board = opts[:board] || @board
    post = opts[:post] || @post
    thrd = post.thrd
    "/boards/#{board.name}/#{thrd.number}/#{post.number}"
  end

  def board_post_url_json(post)
    board_post_url(post) + '.json'
  end

  def board_form_url(opts={})
    board = opts[:board] || @board

    unless @thrd
      "/boards/#{board.name}/new"
    else
      "/boards/#{board.name}/#{@thrd.number}/new"
    end
  end

  def board_delform_url(opts={})
    board = opts[:board] || @board

    unless @thrd
      "/boards/#{board.name}/delete"
    else
      "/boards/#{board.name}/#{@thrd.number}/delete"
    end
  end

  def postername(post)
    name = if !post.postername.empty? then post.postername else post.board.postername_default end
    if post.sage then link_to(name, 'mailto:sage') else name end
  end

  def markup(text)
    replaces = {
                  '\*\*' => [ '<b>', '</b>' ],
                  '\*' => [ '<i>', '</i>' ],
                  '%%' => [ '<span class="spoiler">', '</span>' ]
                }
    replaces.each do |m,x|
      s,e = x
      text = text.gsub /#{m}(.*?)#{m}/, "#{s}\\1#{e}"
    end
    return text
  end

  def quotelinks(text)
    text.gsub /&gt;&gt;(\d+)/, "<a class=\"quotelink\" href=\"#\\1\">&gt;&gt;\\1</a>"
  end

  def process_body(text)
    text = h(text)
    text = quotelinks(markup(text))
    ["\r\n", "\n\r", "\n"].each do |s|
      text = text.gsub(s, '<br />')
    end
    return text.html_safe
  end
end
