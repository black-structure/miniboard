module Admin::UsersHelper
  
  def user_path(x, y=nil)
    admin_user_path(x, y)
  end
  
  def users_path(x=nil)
    admin_users_path(x)
  end
  
  
end
