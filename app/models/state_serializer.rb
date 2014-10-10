class StateSerializer < ActiveRecord::Base
  def self.all_states
    all_states = State.order(:total_power_score).reverse
    all_states.each_with_object(Array.new) do |state, memo|
      next if state.total_power_score < 2
      state_info = {name: state.name,
        total_power_score: state.total_power_score,
        military_score: state.military_score,
        economic_score: state.economic_score,
        soft_power_score: state.soft_power_score,
        population_score: state.population_score
      }
      memo.push( state_info )
    end
  end
end
