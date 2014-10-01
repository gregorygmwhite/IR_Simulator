class State < ActiveRecord::Base
  attr_accessible :name, :country_code,:population, :population_growth, :internet_penetration, :population_score, :soft_power_score, :mnc_points, :military_score, :total_power_score
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
    GoodnessIndex.set_goodness_points
    Mnc.set_mnc_points
    Power.calculate_power
    State.total_power
  end

  def self.total_power
    State.all.each do |state|
      total_power = state.military_score + state.population_score + state.soft_power_score
      total_power+= state.economy.economic_score
      state.update_attributes!(total_power_score: total_power)
    end
  end
end
