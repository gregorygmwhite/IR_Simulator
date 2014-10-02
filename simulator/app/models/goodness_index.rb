class GoodnessIndex < ActiveRecord::Base
  attr_accessible :state_id, :overall_rank, :science_rank, :cultural_rank, :peace_security_rank, :world_order_rank, :planet_climate_rank, :prosperity_equality_rank, :health_rank, :points
  belongs_to :state

  def self.set_goodness_points
    count = GoodnessIndex.count + 1
    GoodnessIndex.all.each do |country_index|
      country_index.update_attributes!(points: (count- country_index.overall_rank))
    end
  end

  def self.get_top_goodness
    GoodnessIndex.order(:points).last.points.to_f
  end
end
