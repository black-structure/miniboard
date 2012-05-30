module Admin::BoardsHelper
  
  def board_path(x, y=nil)
    admin_board_path(x, y)
  end
  
  def boards_path(x=nil)
    admin_boards_path(x)
  end
  
  
end
