class Post
  include Mongoid::Document
  
  belongs_to :thrd
  belongs_to :board
  
  field :number, type: Integer
  field :postername, type: String
  field :subject, type: String
  field :body, type: String
  field :time, type: DateTime
  field :sage, type: Boolean, default: false
  mount_uploader :file, PostImageUploader
  field :image_width, type: Integer
  field :image_height, type: Integer
  field :file_size, type: Integer
  
  index [ [:'board.name', Mongo::ASCENDING], [:number, Mongo::ASCENDING] ], unique: true
  
  before_create :update_time, :update_fileinfo
  before_save :update_time, :update_fileinfo
  
  def image
    @image ||= MiniMagick::Image.open(file.path)
  end
  
  def update_time
    self.time= Time.now
  end

  def update_fileinfo
    if self.file?
      self.file_size ||= file.size
      if !self.image_width || self.image_height
        self.image_width ||= image['width']
        self.image_height ||= image['height']
      end
    end
  end
end
