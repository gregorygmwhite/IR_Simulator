class AddMilitaryPoints < ActiveRecord::Migration
  def change
    add_column :armies, :points, :integer, default: 0
    add_column :navies, :points, :integer, default: 0
    add_column :airforces, :points, :integer, default: 0
    add_column :states, :military_score, :integer, default: 0
  end
end
