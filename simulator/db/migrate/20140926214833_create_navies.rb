class CreateNavies < ActiveRecord::Migration
  def change
    create_table :navies do |t|
      t.integer :state_id
      t.integer :tanks, default: 0
      t.integer :aircraft_carriers, default: 0
      t.integer :amphibious_ships, default: 0
      t.integer :cruisers, default: 0
      t.integer :destroyers, default: 0
      t.integer :frigates, default: 0
      t.integer :corvettes, default: 0
      t.integer :patrol_boats, default: 0
      t.integer :nuclear_submarines, default: 0
      t.integer :submarines, default: 0
      t.integer :combat_aircraft, default: 0
      t.integer :attack_helicopters, default: 0
      t.integer :nuclear_weapons, default: 0
      t.timestamps
    end
  end
end
