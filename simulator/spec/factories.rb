FactoryGirl.define do
  factory :state do
    name "United States"
    country_code "us"
    population 300000000
    population_growth 0.03
    internet_penetration 0.8
    association :economy, factory: :economy
    association :army, factory: :army
    association :navy, factory: :navy
    association :airforce, factory: :airforce
    association :goodness_index, factory: :goodness_index
  end

  factory :china, class: State do 
    name "China"
    country_code "ch"
    population 1300000000
    population_growth 0.01
    internet_penetration 0.6
    association :goodness_index, factory: :goodness_index, overall_rank: 2
  end

  factory :power_model, class: Power do 
    raw_economic_score 0
    raw_military_score 0
    raw_soft_score 0
    raw_population_score 0
    association :state, factory: :state
  end

  factory :power_model_prefilled, class: Power do 
    raw_economic_score 1000000000
    raw_military_score 12456789
    raw_soft_score 35
    raw_population_score 323000000
    association :state, factory: :state
  end

  factory :economy do 
    gdp_ppp 16000000000000
    gdp_per_capita 43000
    gdp_growth 0.02
  end

  factory :army do 
    tanks 8500
    active_troops 1300000
    reserve_troops 500000
    paramilitary_troops 20000
  end

  factory :navy do
    aircraft_carriers 10
    amphibious_ships 30
    cruisers 60
    destroyers 45
    frigates 20
    corvettes 1
    patrol_boats 0
    nuclear_submarines 71
    submarines 2
    combat_aircraft 600
    attack_helicopters 1000
    nuclear_weapons 7700
  end

  factory :airforce do 
    fighters 6000
    bombers 800
    helicopters 800
  end

  factory :goodness_index do 
    overall_rank 1
  end

  factory :mnc do 
    rank 1
    association :state, factory: :state
  end
end