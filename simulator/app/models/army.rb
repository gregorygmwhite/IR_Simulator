class Army < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :state
end
