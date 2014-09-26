class Mnc < ActiveRecord::Base
  attr_accessible :rank, :state_id
  belongs_to :state
end
