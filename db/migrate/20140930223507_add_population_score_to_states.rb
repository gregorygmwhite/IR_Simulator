class AddPopulationScoreToStates < ActiveRecord::Migration
  def change
    add_column :states, :population_score, :integer, default: 0
  end
end
