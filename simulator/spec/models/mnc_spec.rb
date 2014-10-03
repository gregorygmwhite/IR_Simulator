require 'rails_helper'

RSpec.describe Mnc, :type => :model do
  let!(:mnc) {FactoryGirl.create(:mnc)}
  it "should translate mnc rankings into point values" do
    Mnc.set_mnc_points
    expect(mnc.reload.points).to eq(1)
  end
end
