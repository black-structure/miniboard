class User
  include Mongoid::Document
  include RoleModel
  
  devise :database_authenticatable, :rememberable, :trackable

  ## Role-based authorization
  field :role_list, :type => Array
  def roles
    @roles ||= role_list ? role_list.map(&:to_sym) : []
  end
  def roles=(new_roles)
    self.role_list= new_roles.map(&:to_s)
  end
  def has_role?(sym)
    roles.include? sym
  end

  ## Database authenticatable
  field :username,            :type => String, :default => ""
  field :encrypted_password,  :type => String, :default => ""
  index({ username: 1 }, { name: 'index_user_username', unique: true })
  
  ## Validators
  validates_uniqueness_of   :username
  validates_length_of       :password, :minimum => 6, :maximum => 16
  validates_confirmation_of :password

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
end
