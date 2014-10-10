require 'rails_helper'

RSpec.describe Airforce, :type => :model do
  let!(:us) {FactoryGirl.create(:state)}
  it "should calculate the point value of the airforce" do 
    us.airforce.calculate_points
    expect(us.airforce.points).to eq(13600000)
  end
end
