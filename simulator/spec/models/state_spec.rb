require 'rails_helper'

RSpec.describe State, :type => :model do
  it "should be able to create a state" do
    expect{State.create}.to change{State.count}.by(1)
  end
  context "associations" do
    us = FactoryGirl.create(:state)
    it "should associate military tables" do
      us.create_army!
      us.create_navy!
      us.create_airforce!
      expect(us.army).to_not eq(nil)
      expect(us.navy).to_not eq(nil)
      expect(us.airforce).to_not eq(nil)
    end
    it "should associate economy" do
      us.create_economy!
      expect(us.economy).to_not eq(nil)
    end
    it "should associate goodness index" do
      us.create_goodness_index!
      expect(us.goodness_index).to_not eq(nil)
    end
    it "should associate goodness index" do
      expect{us.mncs << Mnc.create}.to change{us.mncs.count}.by(1)
    end
  end
end
