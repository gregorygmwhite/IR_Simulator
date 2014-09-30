class CreatePowers < ActiveRecord::Migration
  def change
    create_table :powers do |t|
      t.integer :state_id
      t.integer :raw_population_score, default: 0
      t.integer :raw_economic_score, default: 0
      t.integer :raw_military_score, default: 0
      t.integer :raw_soft_score, default: 0
      t.timestamps
    end
  end
end
