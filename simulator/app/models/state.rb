class State < ActiveRecord::Base
  attr_accessible :name, :country_code, :population, :population_growth, :internet_penetration, :technology_points, :population_score, :soft_power_score, :mnc_points, :military_score, :economic_score, :total_power_score
  has_many :mncs
  has_one :economy
  has_one :goodness_index
  has_one :army
  has_one :navy
  has_one :airforce
  has_one :power

  # reset mnc_points before recalculating mnc power
  def reset_mnc_points
    self.update_attributes!(mnc_points: 0)
  end

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

  def self.calculate_relative_power
    State.calculate_power_scores
    State.calculate_total_power
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

  def self.calculate_total_power
    State.all.each do |state|
      state.calculate_total_power
    end
  end

  def calculate_total_power
    total_power = self.military_score + self.population_score 
    total_power+= self.economic_score + self.soft_power_score
    self.update_attributes!(total_power_score: total_power)
  end 

  def self.get_top_mnc_points
    State.order(:mnc_points).last.mnc_points.to_f
  end

end
