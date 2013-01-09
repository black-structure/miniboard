//= require jquery-fieldselection

root = exports ? this

class root.ImageBoard
  _instance = undefined
  @get: (args) ->
    _instance ?= new _ImageBoard args

class _ImageBoard
  init: ->
    $(document).ready =>
      @ready()
  ready: ->
    @process_buttons()
    # @process_reflinks()

  process_buttons: ->
    $('#button_set_bold').click (e) =>
      @set_bold_in_post_body()
      e.preventDefault()
    $('#button_set_cursive').click (e) =>
      @set_cursive_in_post_body()
      e.preventDefault()
    $('#button_set_spoiler').click (e) =>
      @set_spoiler_in_post_body()
      e.preventDefault()

  process_reflinks: ->
    alert 'not implemented'

  append_to_post_body: (text) ->
    $('#post_body').val($('#post_body').val() + text)

  _markup_in_post_body: (left,right=left) ->
    selected_text = $('#post_body').getSelection().text
    $('#post_body').replaceSelection(left + selected_text + right)

  set_bold_in_post_body: ->
    @_markup_in_post_body('**')
  set_cursive_in_post_body: ->
    @_markup_in_post_body('*')
  set_spoiler_in_post_body: ->
    @_markup_in_post_body('%%')

