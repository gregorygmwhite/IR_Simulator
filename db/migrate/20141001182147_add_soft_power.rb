class AddSoftPower < ActiveRecord::Migration
  def change
    add_column :states, :soft_power_score, :integer, default: 0
    add_column :states, :mnc_points, :integer, default: 0
    add_column :states, :technology_points, :integer, default: 0
    add_column :mncs, :points, :integer, default: 0
    add_column :goodness_indices, :points, :integer, default: 0
  end
end
