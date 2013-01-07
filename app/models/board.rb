class Board
  include Mongoid::Document
  
  has_many :thrds
  
  field :name, type: String
  field :description, type: String
  field :postername_default, type: String
  field :counter, type: Integer, default: 0
  field :perpage, type: Integer, default: 15
  field :replies_on_index, type: Integer, default: 5
  field :maxthrds, type: Integer, default: 60
  field :maxfilesize, type: Integer, default: 1024*1024
  
  index({ name: 1 }, { name: 'index_board_name', unique: true })
  
  validates_presence_of :name

  validate do |board|
    errors.add(:perpage, 'This field allows only positive values') unless board.perpage >= 1
    errors.add(:replies_on_index, 'This field allows only positive values') unless board.replies_on_index >= 1
    errors.add(:maxthrds, 'This field allows only positive values') unless board.maxthrds >= 1
    errors.add(:maxfilesize, 'This field allows only positive values') unless board.maxfilesize >= 1
  end
  
  def inc_number
    inc(:counter, 1)
    counter
  end
  
end
