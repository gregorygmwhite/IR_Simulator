FactoryGirl.define do
  factory :state do
    name "United States"
    country_code "us"
    population 300000000
    population_growth 0.03
    internet_penetration 0.8
  end

  factory :china, class: State do 
    name "China"
    country_code "ch"
    population 1300000000
    population_growth 0.01
    internet_penetration 0.6
  end

  # factory :power do 
  #   raw_economic_score 1000000000
  #   raw_military_score 12456789
  #   raw_soft_score 35
  #   raw_population_score 323000000
  # end

  factory :mnc do 
    rank 1
    points 50
  end
end