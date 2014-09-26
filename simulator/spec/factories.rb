FactoryGirl.define do
  factory :state do
    name "United States"
    country_code "us"
    population 300000000
    population_growth 0.03
    internet_penetration 0.8
  end
end