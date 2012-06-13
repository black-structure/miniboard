class AdminController < ActionController::Base
  protect_from_forgery
  before_filter :init, :authenticate_user!
  after_filter :installation
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/"
  end
  
  protected
  
  def init
    @installing = (User.count == 0)
    
    if @installing && params[:controller] != 'admin/users' 
      redirect_to :controller => 'admin/users', :action => 'new'
    end
  end
  
  def authenticate_user!
    return if @installing
    super
  end
  
  def installation
    return if !@installing
    
    # TODO: some installation actions
  end
  
  #private
  #def current_user
  #  session[:current_user]
  #end
end
