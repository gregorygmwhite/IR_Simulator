class CreateAirforces < ActiveRecord::Migration
  def change
    create_table :airforces do |t|
      t.integer :state_id
      t.integer :fighters, default: 0
      t.integer :bombers, default: 0
      t.integer :helicopters, default: 0
      t.timestamps
    end
  end
end
