class AddEconomicScore < ActiveRecord::Migration
  def change
    add_column :states, :economic_score, :integer, default: 0
  end
end
