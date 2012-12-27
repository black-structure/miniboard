class Admin::HomeController < AdminController
  def index
    @b1 = can? :read, ::Board.first
  end
end
