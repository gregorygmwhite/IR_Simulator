module CountryDataLoader
  require 'json'
  def self.help
    puts "CountryDataLoader::get_country_data(country_code) => given a country code will return a ruby hash with all data for that country"
  end

  def self.get_country_data(country_code)
    JSON.parse( IO.read("countries_data/#{country_code}.json") )
  end
end