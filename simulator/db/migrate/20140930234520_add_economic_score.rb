class AddEconomicScore < ActiveRecord::Migration
  def change
    add_column :economies, :economic_score, :integer, default: 0
  end
end
