class AddTotalPowerScore < ActiveRecord::Migration
  def change
    add_column :states, :total_power_score, :integer, default: 0
  end
end
