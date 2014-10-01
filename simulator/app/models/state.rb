class State < ActiveRecord::Base
  attr_accessible :name, :country_code,:population, :population_growth, :internet_penetration, :population_score, :soft_power_score, :mnc_points
  has_many :mncs
  has_one :economy
  has_one :goodness_index
  has_one :army
  has_one :navy
  has_one :airforce
  has_one :power

  def self.calculate_power
    Array(State.all).each do |current_state|
      current_state.power.calculate_raw_power
    end
    Power.calculate_power
  end
end
