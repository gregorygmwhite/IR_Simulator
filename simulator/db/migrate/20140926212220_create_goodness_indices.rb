class CreateGoodnessIndices < ActiveRecord::Migration
  def change
    create_table :goodness_indices do |t|
      t.integer :state_id
      t.integer :overall_rank
      t.integer :science_rank
      t.integer :cultural_rank
      t.integer :peace_security_rank
      t.integer :world_order_rank
      t.integer :prosperity_equality_rank
      t.integer :health_rank
      t.timestamps
    end
  end
end
