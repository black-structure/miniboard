require 'test_helper'

class BoardHelperTest < ActionView::TestCase
  test "markup" do
    assert markup('**') == '<i></i>'
    assert markup('****') == '<b></b>'
    assert markup('******') == '<b></b><i></i>'
    assert markup('*cursive*,**bold**') == '<i>cursive</i>,<b>bold</b>'
  end
end
