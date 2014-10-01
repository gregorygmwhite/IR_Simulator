class Airforce < ActiveRecord::Base
  attr_accessible :state_id, :fighters, :bombers, :helicopters, :points
  belongs_to :state
end
