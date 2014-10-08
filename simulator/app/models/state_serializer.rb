class StateSerializer < ActiveRecord::Base
  def self.all_states
    all_states = State.order(:total_power_score).reverse
    all_states.each_with_object(Hash.new(0)) do |state, memo|
      memo[state.name] = {
        total_power_score: state.total_power_score,
        economic_score: state.economic_score,
        soft_power_score: state.soft_power_score,
        military_score: state.military_score,
        population_score: state.population_score
      }
    end
  end
end
