require 'rails_helper'

RSpec.describe State, :type => :model do
  it "should be able to create a state" do
    expect{State.create}.to change{State.count}.by(1)
  end
  context "associations" do
    let(:us) {FactoryGirl.create(:state)}
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
    it "should associate multinational corporations" do
      expect{us.mncs << Mnc.create}.to change{us.mncs.count}.by(1)
    end

    it "should associate power model" do
      us.create_power!
      expect(us.power).to_not eq(nil)
    end
  end

  context "State Power Calculations" do
    context "Multinational corporation points" do 
      it "should reset mnc points" do 
        mnc = FactoryGirl.create(:mnc)
        Mnc.set_mnc_points
        state = mnc.state.reload
        expect(state.mnc_points).to eq(1)
        state.reset_mnc_points
        expect(state.mnc_points).to eq(0)
      end

      it "should get mnc_points from the state with highest mnc_points" do
        mnc = FactoryGirl.create(:mnc)
        Mnc.set_mnc_points
        us = mnc.state.reload
        expect(State.get_top_mnc_points).to_not eq(0)
        expect(State.get_top_mnc_points).to eq(us.mnc_points.to_f)
      end
    end
    context "state instance power calculation" do 
      let(:us) { FactoryGirl.create(:state) }
      it "should calculate a state's total power from composite power scores" do
        scores = {military_score: 100, economic_score: 100, soft_power_score: 100, population_score: 100}
        us.update_attributes(scores)
        us.calculate_total_power
        expect(us.total_power_score).to eq(400)
      end
    end

    context "State power calculation" do 
      let(:us) { FactoryGirl.create(:state) }
      let(:ch) { FactoryGirl.create(:china) }
      let(:scores) {{military_score: 100, economic_score: 100, soft_power_score: 100,
                      population_score: 100, mnc_points: 20}}
      it "should calculate all states' total power from composite power scores" do
        us.update_attributes!(scores)
        scores[:military_score] = 200
        ch.update_attributes!(scores)
        State.calculate_total_power
        expect(us.reload.total_power_score).to eq(400)
        expect(ch.reload.total_power_score).to eq(500)
      end
      it "should calculate all states' power composite power scores" do
        us.update_attributes!(scores)
        raw_scores = {raw_military_score: 10000000, raw_economic_score: 16000000000, 
          raw_population_score: 323000000, raw_soft_score: 0}
        us.create_power!(raw_scores)
        us.create_goodness_index!(overall_rank: 1)
        State.calculate_power_scores
        expect(us.reload.military_score).to eq(1000)
      end

    end

  end
end
