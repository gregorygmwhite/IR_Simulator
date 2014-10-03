require 'rails_helper'

RSpec.describe Navy, :type => :model do
  let!(:us) {FactoryGirl.create(:state)}
  it "should calculate the point value of the navy" do 
    us.navy.calculate_points
    expect(us.navy.points).to eq(16111000)
  end
end
