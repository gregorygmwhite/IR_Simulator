require_relative "data/countries.rb"
require_relative "data/country_data_loader"

countries_list = CountryList.get_country_list
countries_list["all"].each do |country_code|
  country = countries_list[country_code]
  country = country.split(" ").map!{|word| word.capitalize!}.join(" ")
  filepath = File.expand_path("../data/countries_data/#{country_code}.json", __FILE__)
  population,growth = CountryDataLoader::get_population_stats(country_code, filepath)
  State.create(name: country, country_code: country_code, population: population, population_growth: growth)
end

