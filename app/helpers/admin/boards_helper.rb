module Admin::BoardsHelper
  #alias :board_path :admin_board_path

  def board_path(x, y=nil)
    admin_board_path(x, y)
  end
  
  def boards_path(x=nil)
    admin_boards_path(x)
  end
  
  
end
