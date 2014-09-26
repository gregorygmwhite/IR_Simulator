class State < ActiveRecord::Base
  attr_accessible :name, :country_code,:population, :population_growth, :internet_penetration
  has_many :mncs
  has_one :economy
  has_one :goodness_index
  has_one :army
  has_one :navy
  has_one :airforce
end
