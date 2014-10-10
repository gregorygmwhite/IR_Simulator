class Mnc < ActiveRecord::Base
  attr_accessible :rank, :state_id, :name, :points
  belongs_to :state

  def self.set_mnc_points
    mnc_count = Mnc.count + 1
    Mnc.all.each do |mnc|
      current_state = mnc.state
      points = (mnc_count - mnc.rank)
      mnc.update_attributes!(points: points)
      current_state.update_attributes!(mnc_points: (current_state.mnc_points + points))
    end
  end
end
