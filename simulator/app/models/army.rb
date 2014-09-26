class Army < ActiveRecord::Base
  attr_accessible :state_id, :active_troops, :reserve_troops, :paramilitary_troops, :tanks
  belongs_to :state
end
