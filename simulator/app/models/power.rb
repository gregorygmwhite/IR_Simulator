class Power < ActiveRecord::Base
  attr_accessible :raw_population_score, :raw_economic_score, :raw_military_score, :raw_soft_score
  belongs_to :state

  def calculate_raw_power
    calculate_projected_population
    calculate_projected_economy
  end

  def calculate_projected_population
    current_state = self.state
    # projected population in five years = raw population score
    projected_population = current_state.population*((1+ (current_state.population_growth/100))**5)
    self.update_attributes!(raw_population_score: projected_population)
  end

  def calculate_projected_economy
    current_state = self.state
    # 1/3 of projected growth in five years is the modifier
    economy = current_state.economy.gdp_ppp
    projected_growth = economy*((1+(current_state.economy.gdp_growth))**5) - economy
    projected_economy = economy + projected_growth * 0.333333333333
    self.update_attributes!(raw_economic_score: projected_economy)
  end

  def self.calculate_power
    top_population_score = (Power.order(:raw_population_score).last.raw_population_score).to_f
    top_economic_score = (Power.order(:raw_economic_score).last.raw_economic_score).to_f
    State.all.each do |current_state|
      current_state.power.calculate_population_power(top_population_score)
      current_state.power.calculate_economic_power(top_economic_score)
    end
  end

  def calculate_population_power(top_population_score)
    # scales raw population score to a max score of 500
    current_state = self.state
    percentage = self.raw_population_score / top_population_score
    population_score = 500 * percentage
    current_state.update_attributes(:population_score => population_score)
  end

  def calculate_economic_power(top_economic_score)
    # scales raw economic score to a max score of 1000
    current_state = self.state
    percentage = self.raw_economic_score / top_economic_score
    economic_score = 1000 * percentage
    current_state.economy.update_attributes(:economic_score => economic_score)
  end
end
