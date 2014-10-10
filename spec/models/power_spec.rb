require 'rails_helper'

ECON_CEILING = 750
POP_CEILING = 400
MILITARY_CEILING = 1000

RSpec.describe Power, :type => :model do
  it "should create a power model" do 
    power = FactoryGirl.create(:power_model)
    expect(power)
  end
  context "raw power calculations" do 
    let(:power) {FactoryGirl.create(:power_model)}
    it "should calculate raw population points" do 
      power.calculate_population_points
      expect(power.raw_population_score).to eq(347782222)
    end
    it "should calculate raw economic points" do 
      power.calculate_economic_points
      expect(power.raw_economic_score).to eq(16555097617066)
    end
    it "should calculate raw military points" do 
      power.calculate_military_points
      expect(power.raw_military_score).to eq(33054333)
    end
  end
  context "relative power calculations" do
    let(:power) {FactoryGirl.create(:power_model)}
    it "should calculate soft power score" do 
      power.calculate_soft_power(121, 50)
      expect(power.raw_soft_score).to eq(40)
      expect(power.state.soft_power_score).to eq(40)
    end

    it "should calculate economic power score" do 
      power.calculate_economic_points
      power.calculate_economic_power(16555097617066)
      expect(power.state.economic_score).to eq(ECON_CEILING)
    end

    it "should calculate military power score" do 
      power.calculate_military_points
      power.calculate_military_power(33054333)
      expect(power.state.military_score).to eq(MILITARY_CEILING)
    end

    it "should calculate population power score" do 
      power.calculate_population_points
      power.calculate_population_power(347782222)
      expect(power.state.population_score).to eq(POP_CEILING)
    end
  end

  context "getting top power scores" do
    let(:power) {FactoryGirl.create(:power_model)}

    it "should get the top population score" do 
      power.calculate_population_points
      expect(Power.get_top_population).to eq(347782222)
    end

    it "should get the top economic score" do 
      power.calculate_economic_points
      expect(Power.get_top_economy).to eq(16555097617066)
    end

    it "should get the top military score" do 
      power.calculate_military_points
      expect(Power.get_top_military).to eq(33054333)
    end

  end
end
