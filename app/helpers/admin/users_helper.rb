module Admin::UsersHelper
#  alias_method :user_path, :admin_user_path
#  alias_method :users_path, :admin_users_path
  def user_path(x, y=nil)
    admin_user_path(x, y)
  end
  
  def users_path(x=nil)
    admin_users_path(x)
  end
end
