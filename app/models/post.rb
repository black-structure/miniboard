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
  field :sage, type: Boolean, default: false
  mount_uploader :file, PostImageUploader
  field :image_width, type: Integer
  field :image_height, type: Integer
  field :file_size, type: Integer
  field :password_hash, type: String
 
  index({ board: 1, number: 1 }, { unique: true })
  
  before_save :update_fileinfo
  
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

  def password
    if @empty
      ""
    else
      @password ||= Password.new(password_hash)
    end
  end

  def password=(new_password)
    @password = new_password
    if !@empty
      self.password_hash = Password.create(new_password)
    end
  end
end
