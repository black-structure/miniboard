class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt
  
  belongs_to :thrd
  belongs_to :board
  
  field :number, type: Integer
  field :postername, type: String
  field :subject, type: String
  field :body, type: String
  field :sage, type: Boolean, default: false
  mount_uploader :file, PostImageUploader
  field :image_width, type: Integer
  field :image_height, type: Integer
  field :file_size, type: Integer
  field :password_hash, type: String
  attr_accessor :password
  
  index [ [:'board.name', Mongo::ASCENDING], [:number, Mongo::ASCENDING] ], unique: true
  
  # before_create :update_fileinfo, :encrypt_password
  before_save :update_fileinfo, :encrypt_password
  
  def image
    @image ||= MiniMagick::Image.open(file.path)
  end
  
  def update_fileinfo
    if self.file?
      self.file_size ||= file.size
      self.image_width ||= image['width']
      self.image_height ||= image['height']
    end
  end

  def encrypt_password
    self.password_hash = Password.create(@password)
  end
end
