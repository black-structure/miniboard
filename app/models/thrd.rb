class Thrd
  include Mongoid::Document
  
  has_many :posts
  belongs_to :board
  
  field :number, type: Integer
  field :last_time, type: DateTime
  
  index [ [:'board.name', Mongo::ASCENDING], [:number, Mongo::ASCENDING] ], unique: true
  
  def count
    posts.count
  end
  
  def bump!(post)
    update_attribute(:last_time, post.created_at)
  end
  
  store_in :threads
end
