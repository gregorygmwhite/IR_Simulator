class CreateMncs < ActiveRecord::Migration
  def change
    create_table :mncs do |t|
      t.integer :rank
      t.integer :state_id
      t.string :name
      t.timestamps
    end
  end
end
