require 'csv'
module CountryDataLoader
  require 'json'
  def self.help
    puts "CountryDataLoader::get_country_data(country_code) => given a country code will return a ruby hash with all data for that country"
  end

  def self.get_country_data(country_code,filepath)
    JSON.parse( IO.read(filepath) )
  end

  def self.get_population_stats(country_code)
    filepath = File.expand_path("../countries_data/#{country_code}.json", __FILE__)
    country_data_json = get_country_data(country_code,filepath)
    population = country_data_json["people"]["population"]["text"].gsub(/ (.*est.)/,"")
    growth = country_data_json["people"]["population_growth_rate"]["text"].gsub(/% (.*est.)/,"")
    population = population.gsub(/,/,"").to_i
    return population,growth.to_f
  end

  def self.get_internet_users(internet_users={})
    filepath = File.expand_path("../raw_datasets/internet_users.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      internet_users[row[0]] = (row[2].to_f)/100
    end
    return internet_users
  end
end