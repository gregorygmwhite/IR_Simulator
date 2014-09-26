class Economy < ActiveRecord::Base
  attr_accessible :state_id, :gdp_ppp, :gdp_per_capita, :gdp_growth
  belongs_to :state
end
