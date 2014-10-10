class Army < ActiveRecord::Base
  attr_accessible :state_id, :active_troops, :reserve_troops, :paramilitary_troops, :tanks, :points
  belongs_to :state

  ACTIVE_POINTS = 1
  RESERVE_POINTS = (2/3.0)
  PARAMILITARY_POINTS = 0.5
  TANKS_POINTS = 200

  def calculate_points
    tanks = self.tanks * TANKS_POINTS
    active = self.active_troops * ACTIVE_POINTS
    reserve = self.reserve_troops * RESERVE_POINTS
    para = self.paramilitary_troops * PARAMILITARY_POINTS
    points= active + reserve + para + tanks
    self.update_attributes!(points: points)
    return points
  end
end
