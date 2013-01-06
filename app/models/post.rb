class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  attr_accessor :empty
  
  belongs_to :thrd
  belongs_to :board
  
  field :number, type: Integer
  field :postername, type: String
  field :subject, type: String
  field :body, type: String
  field :sage, type: Boolean#, default: false
  mount_uploader :file, PostImageUploader
  field :image_width, type: Integer
  field :image_height, type: Integer
  field :file_size, type: Integer
  field :password_hash, type: String

  validate do
    if file? && file_size > board.maxfilesize
      errors.add :file, "Max file size is #{board.maxfilesize}"
    end
  end

  validate do
    if !thrd && !file?
      errors.add :file, "Need a picture to start a thread"
    end
  end

  validate do
    if thrd && (!file? && (!body || body.empty?))
      errors.add :body, "Empty message detected"
    end
  end
 
  index({ board: 1, number: 1 }, { unique: true })
  
  before_save :optimize_fields
  before_validation :update_fileinfo
  
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

  def optimize_fields
    self.remove_attribute(:sage) unless self.sage
    self.remove_attribute(:password_hash) unless self.password && !self.password.empty?
  end

  def password
    if @empty
      ""
    else
      @password ||= password_hash ? Password.new(password_hash) : ""
    end
  end

  def password=(new_password)
    @password = new_password
    if !@empty
      self.password_hash = Password.create(new_password)
    end
  end
end
