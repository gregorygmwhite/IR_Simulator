class Navy < ActiveRecord::Base
  attr_accessible :state_id, :tanks, :aircraft_carriers, :amphibious_ships, :cruisers, :destroyers, :frigates, :corvettes, :patrol_boats, :nuclear_submarines, :submarines, :combat_aircraft, :attack_helicopters, :nuclear_weapons, :points
  belongs_to :state

  TANKS_POINTS = 100
  AIRCRAFT_CARRIER_POINTS = 100000
  CRUISER_POINTS = 10000
  DESTROYER_POINTS = 25000
  FRIGATE_POINTS = 15000
  CORVETTE_POINTS = 1000
  NUKE_SUB_POINTS = 25000
  SUB_POINTS = 10000
  HELICOPTER_POINTS = 500

  def calculate_points
    tanks = self.tanks * TANKS_POINTS
    ac = self.aircraft_carriers * AIRCRAFT_CARRIER_POINTS
    crus = self.cruisers * CRUISER_POINTS
    dest = self.destroyers * DESTROYER_POINTS
    frig = self.frigates * FRIGATE_POINTS
    corv = self.corvettes * CORVETTE_POINTS
    nuke = self.nuclear_submarines * NUKE_SUB_POINTS
    sub = self.submarines * SUB_POINTS
    helis = self.attack_helicopters * HELICOPTER_POINTS
    points = tanks + ac + crus+ dest+ frig + nuke + corv + sub + helis
    self.update_attributes!(points: points)
    return points
  end

end
