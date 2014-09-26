class State < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :mncs
  has_one :economy
  has_one :goodness_index
  has_one :army
  has_one :navy
  has_one :airforce
end
