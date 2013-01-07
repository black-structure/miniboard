class Thrd
  include Mongoid::Document
  
  has_many :posts
  belongs_to :board
  
  field :number, type: Integer
  field :last_time, type: DateTime
  field :count, type: Integer
  field :count_files, type: Integer

  index({ board: 1, number: 1 }, { unique: true })
  
  def bump!(post)
    update_attribute(:last_time, post.created_at)
  end

  def update_counters!(post)
    if post
      inc(:count, 1)
      inc(:count_files, 1) if post.file?
    end
  end
  
  store_in collection: 'threads'
end
