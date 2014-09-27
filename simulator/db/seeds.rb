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

load_countries
load_internet_users
load_mncs