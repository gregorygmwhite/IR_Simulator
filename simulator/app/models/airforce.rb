class Airforce < ActiveRecord::Base
  attr_accessible :state_id, :fighters, :bombers, :helicopters, :points
  belongs_to :state

  FIGHTERS_POINTS = 1000
  BOMBERS_POINTS = 1000
  HELICOPTER_POINTS = 500

  def calculate_points
    fighters = self.fighters * FIGHTERS_POINTS
    bombers = self.bombers * BOMBERS_POINTS
    helis = self.helicopters * HELICOPTER_POINTS
    points = fighters + bombers + helis
    self.update_attributes!(points: points)
    return points
  end
end
