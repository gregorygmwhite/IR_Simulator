class State < ActiveRecord::Base
  attr_accessible :name, :country_code,:population, :population_growth, :internet_penetration, :population_score, :soft_power_score, :mnc_points, :military_score, :economic_score, :total_power_score
  has_many :mncs
  has_one :economy
  has_one :goodness_index
  has_one :army
  has_one :navy
  has_one :airforce
  has_one :power

  def self.recalculate_power
    State.calculate_power_components
    State.calculate_relative_power
  end

  def self.calculate_power_components
    Array(State.all).each do |current_state|
      current_state.power.calculate_raw_power
      current_state.reset_mnc_points
    end
    GoodnessIndex.set_goodness_points
    Mnc.set_mnc_points
  end

  # reset mnc_points before recalculating mnc power
  def reset_mnc_points
    self.update_attributes!(mnc_points: 0)
  end

  def self.calculate_relative_power
    State.calculate_power_scores
    State.total_power
  end

  def self.calculate_power_scores
    top_population_score = Power.get_top_population
    top_economic_score = Power.get_top_economy
    top_goodness_score = GoodnessIndex.get_top_goodness
    top_mnc_score = State.get_top_mnc_points
    top_military_score = Power.get_top_military

    State.all.each do |current_state|
      current_state.power.calculate_population_power(top_population_score)
      current_state.power.calculate_economic_power(top_economic_score)
      current_state.power.calculate_soft_power(top_goodness_score, top_mnc_score)
      current_state.power.calculate_military_power(top_military_score)
    end
  end

  def self.total_power
    State.all.each do |state|
      total_power = state.military_score + state.population_score 
      total_power+= state.economic_score + state.soft_power_score
      state.update_attributes!(total_power_score: total_power)
    end
  end

  def self.get_top_mnc_points
    State.order(:mnc_points).last.mnc_points.to_f
  end

end
