class Power < ActiveRecord::Base
  attr_accessible :raw_population_score, :raw_economic_score, :raw_military_score, :raw_soft_score
  belongs_to :state

  ECON_CEILING = 750
  POP_CEILING = 400
  MILITARY_CEILING = 1000

  def calculate_raw_power
    calculate_population_points
    calculate_economic_points
    calculate_military_points
  end

  def calculate_population_points
    current_state = self.state
    # projected population in five years = raw population score
    population_points = current_state.population*((1+ (current_state.population_growth))**5)
    self.update_attributes!(raw_population_score: population_points)
  end

  def calculate_economic_points
    current_state = self.state
    # 1/3 of projected growth in five years is the modifier
    economy = current_state.economy.gdp_ppp if current_state.economy
    projected_growth = economy*((1+(current_state.economy.gdp_growth))**5) - economy
    economic_points = economy + projected_growth * 0.333333333333
    self.update_attributes!(raw_economic_score: economic_points)
  end

  def calculate_military_points
    return unless self.state.army
    army,navy,airforce = 0,0,0
    army = self.state.army.calculate_points
    navy = self.state.navy.calculate_points if self.state.navy
    airforce = self.state.airforce.calculate_points if self.state.airforce
    points = army + navy + airforce
    self.update_attributes(raw_military_score: points)
  end

  def calculate_population_power(top_population_score)
    # scales raw population score to a max score of 500
    current_state = self.state
    percentage = self.raw_population_score / top_population_score
    population_score = POP_CEILING * percentage
    current_state.update_attributes(:population_score => population_score)
  end

  def calculate_economic_power(top_economic_score)
    # scales raw economic score to a max score of 750
    current_state = self.state
    percentage = self.raw_economic_score / top_economic_score
    economic_score = ECON_CEILING * percentage
    current_state.update_attributes!(:economic_score => economic_score)
  end

  def calculate_soft_power(top_goodness_score, top_mnc_score)
    state,goodness = self.state,0
    tech_score = state.internet_penetration * 50
    if(state.goodness_index && state.goodness_index.points != 0)
      goodness = 50 * (state.goodness_index.points / top_goodness_score)
    end
    mnc_score = 50 * (state.mnc_points / top_mnc_score)
    soft_power_score = mnc_score + goodness + tech_score
    self.update_attributes!(:raw_soft_score => soft_power_score)
    state.update_attributes!({technology_points: tech_score, soft_power_score: soft_power_score})
  end

  def calculate_military_power(top_military_score)
    # scales raw military score to a max score of 1000
    current_state = self.state
    percentage = self.raw_military_score / top_military_score
    military_score = percentage * MILITARY_CEILING
    current_state.update_attributes!(military_score: military_score)
  end

  def self.get_top_population
    top_pop = Power.order(:raw_population_score).last
    top_score = top_pop.raw_population_score
    return top_score.to_f
  end

  def self.get_top_economy
    top_econ = Power.order(:raw_economic_score).last
    top_score = top_econ.raw_economic_score
    return top_score.to_f
  end

  def self.get_top_military
    top_military = Power.order(:raw_military_score).last
    top_score = top_military.raw_military_score
    return top_score.to_f
  end

end
