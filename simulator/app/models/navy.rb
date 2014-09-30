class Navy < ActiveRecord::Base
  attr_accessible :state_id, :tanks, :aircraft_carriers, :amphibious_ships, :cruisers, :destroyers, :frigates, :corvettes, :patrol_boats, :nuclear_submarines, :submarines, :combat_aircraft, :attack_helicopters, :nuclear_weapons
  belongs_to :state
end
