class Board
  include Mongoid::Document
  
  has_many :thrds
  
  field :name, type: String
  field :description, type: String
  field :postername_default, type: String
  field :counter, type: Integer, default: 0
  field :perpage, type: Integer, default: 15
  field :maxthrds, type: Integer, default: 60
  
  index({ name: 1 }, { name: 'index_board_name', unique: true })
  
  validates_presence_of :name
  
  def inc_number
    inc(:counter, 1)
    counter
  end
  
end
