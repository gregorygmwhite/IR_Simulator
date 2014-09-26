class Airforce < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :state
end
