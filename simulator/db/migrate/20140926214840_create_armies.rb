class CreateArmies < ActiveRecord::Migration
  def change
    create_table :armies do |t|
      t.integer :state_id
      t.integer :active_troops, default: 0
      t.integer :reserve_troops, default: 0
      t.integer :paramilitary_troops, default: 0
      t.timestamps
    end
  end
end
