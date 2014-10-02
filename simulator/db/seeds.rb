require_relative "data/countries.rb"
require_relative "data/country_data_loader"

$countries_list = CountryList.get_country_list
def load_countries
  $countries_list["all"].each do |country_code|
    country = $countries_list[country_code]
    country = country.split(" ").map!{|word| word.capitalize!}.join(" ")
    population,growth = CountryDataLoader::get_population_stats(country_code)
    State.create(name: country, country_code: country_code, population: population, population_growth: growth)
  end
end

def load_internet_users
  internet_users = CountryDataLoader::get_internet_users
  internet_users.each_pair do |state_name, internet_penetration|
    current_state = State.find_by_name(state_name)
    next unless current_state
    current_state.update_attributes(internet_penetration: internet_penetration)
  end
end

def load_mncs
  mncs = CountryDataLoader::get_mncs
  mncs.each_pair do |mnc_name, mnc_info|
    country_code,rank = mnc_info[:country_code], mnc_info[:rank].to_i
    current_state = State.find_by_country_code(country_code)
    next unless current_state
    current_state.mncs << Mnc.create({name: mnc_name, rank: rank})
  end
end

def load_economies
  $countries_list["all"].each do |country_code|
    current_state = State.find_by_country_code(country_code)
    next unless current_state
    gdp,per_capita,growth = CountryDataLoader::get_economic_stats(country_code)
    current_state.create_economy(gdp_ppp: gdp,gdp_per_capita: per_capita, gdp_growth: growth)
  end
end

def load_goodness
  goodness_rankings = CountryDataLoader::get_goodness_data
  goodness_rankings.each_pair do |country_name, goodness_info|
    current_state = State.find_by_name(country_name)
    next unless current_state
    current_state.create_goodness_index!(goodness_info)
  end
end

def load_airforce
  airforce = CountryDataLoader::get_airforce_data
  airforce.each_pair do |country_name, airforce_info|
    current_state = State.find_by_name(country_name)
    next unless current_state
    current_state.create_airforce!(airforce_info)
  end
end

def load_army
  army = CountryDataLoader::get_army_data
  army.each_pair do |country_name, army_info|
    current_state = State.find_by_name(country_name)
    next unless current_state
    current_state.create_army!(army_info)
  end
end

def load_navy
  navy,tanks = CountryDataLoader::get_navy_data
  navy.each_pair do |country_name, navy_info|
    current_state = State.find_by_name(country_name)
    next unless current_state
    current_state.create_navy!(navy_info)
    current_state.army.update_attributes!(tanks: tanks[country_name])
  end
end

def create_powers
  State.all.each do |current_state|
    current_state.create_power!
  end
end

def initial_power_calculation
  State.calculate_power
end

load_countries
load_internet_users
load_mncs
load_economies
load_goodness
load_airforce
load_army
load_navy
create_powers
initial_power_calculation