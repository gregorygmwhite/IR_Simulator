class CreateEconomies < ActiveRecord::Migration
  def change
    create_table :economies do |t|
      t.integer :state_id
      t.integer :gdp_ppp, default: 0
      t.integer :gdp_per_capita, default: 0
      t.decimal :gdp_growth, default: 0.0
      t.timestamps
    end
  end
end
