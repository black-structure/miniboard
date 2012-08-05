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
  
  index [ [:'board.name', Mongo::ASCENDING], [:number, Mongo::ASCENDING] ], unique: true
  
  before_create :update_post_time
  before_save :update_post_time
  
  protected
  def update_post_time
    self.time= Time.now
  end
  
end
