class Mnc < ActiveRecord::Base
  attr_accessible :rank, :state_id, :name
  belongs_to :state
end
