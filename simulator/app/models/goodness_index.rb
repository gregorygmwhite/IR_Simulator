class GoodnessIndex < ActiveRecord::Base
  attr_accessible :state_id, :overall_rank, :science_rank, :cultural_rank, :peace_security_rank, :world_order_rank, :prosperity_equality_rank, :health_rank
  belongs_to :state
end
