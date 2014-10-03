require 'rails_helper'

RSpec.describe Army, :type => :model do
  let!(:us) {FactoryGirl.create(:state)}
  it "should calculate the point value of the army" do 
    us.army.calculate_points
    expect(us.army.points).to eq(3343333)
  end
end
