require 'rails_helper'

RSpec.describe GoodnessIndex, :type => :model do
  context "class methods" do 
    let!(:us) {FactoryGirl.create(:state)}
    let!(:china) {FactoryGirl.create(:china)}
    it "should get the points from the coutnry with the top goodness index" do
      GoodnessIndex.set_goodness_points
      expect(GoodnessIndex.get_top_goodness).to eq(2.0)
    end

    it "should translate goodness index data into a point value" do 
      GoodnessIndex.set_goodness_points
      expect(us.reload.goodness_index.points).to eq(2)
    end
  end
end
