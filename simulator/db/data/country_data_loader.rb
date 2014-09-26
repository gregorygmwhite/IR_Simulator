require 'debugger'
module CountryDataLoader
  require 'json'
  def self.help
    puts "CountryDataLoader::get_country_data(country_code) => given a country code will return a ruby hash with all data for that country"
  end

  def self.get_country_data(country_code,filepath)
    JSON.parse( IO.read(filepath) )
  end

  def self.get_population_stats(country_code, filepath)
    country_data_json = get_country_data(country_code,filepath)
    population = country_data_json["people"]["population"]["text"].gsub(/ (.*est.)/,"")
    growth = country_data_json["people"]["population_growth_rate"]["text"].gsub(/% (.*est.)/,"")
    population = population.gsub(/,/,"").to_i
    growth = growth.to_f
    return population,growth
  end
end