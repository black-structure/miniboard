class User
  include Mongoid::Document
  include RoleModel
  
  devise :database_authenticatable, :rememberable, :trackable

  ## Role-based authorization
  roles :guest, :moderator, :admin
  field :roles_mask, :default => 1 # only anonymous 'guest' by default

  ## Database authenticatable
  field :username,            :type => String, :null => false, :default => ""
  field :encrypted_password,  :type => String, :null => false, :default => ""
  index :username,            :unique => true
  
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
