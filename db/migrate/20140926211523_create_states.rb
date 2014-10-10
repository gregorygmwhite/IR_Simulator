class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :country_code
      t.string :name
      t.integer :population, default: 0
      t.float :population_growth, default: 0.0
      t.float :internet_penetration, default: 0.0
      t.timestamps
    end
  end
end
