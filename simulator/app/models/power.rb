class Power < ActiveRecord::Base
  attr_accessible :raw_population_score, :raw_economic_score, :raw_military_score, :raw_soft_score
  belongs_to :state

  def calculate_raw_power
    calculate_projected_population
  end

  def calculate_projected_population
    current_state = self.state
    # projected population in five years = raw population score
    projected_population = current_state.population*((1+ (current_state.population_growth/100))**5)
    self.update_attributes!(raw_population_score: projected_population)
  end

  def self.calculate_power
    Power.calculate_population_power
  end

  def self.calculate_population_power
    top_population_score = (Power.order(:raw_population_score).last.raw_population_score).to_f
    State.all.each do |current_state|
      # scales raw population score to a max score of 500
      percentage = current_state.power.raw_population_score / top_population_score
      population_score = 500 * percentage
      current_state.update_attributes(:population_score => population_score)
    end
  end
end
