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

  def self.get_mncs(mncs={})
    filepath = File.expand_path("../raw_datasets/MNC_2013.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      mncs[row[1]] = {rank: row[0], country_code: row[2]}
    end
    return mncs
  end

  def self.get_economic_stats(country_code)
    filepath = File.expand_path("../countries_data/#{country_code}.json", __FILE__)
    country_data_json = get_country_data(country_code,filepath)
    gdp = strip_cia_numbers(country_data_json["econ"]["gdp_purchasing_power_parity"]["text"])
    per_capita = strip_cia_numbers(country_data_json["econ"]["gdp_per_capita_ppp"]["text"])
    growth = strip_cia_numbers(country_data_json["econ"]["gdp_real_growth_rate"]["text"])
    return gdp,per_capita,(growth/100)
  end

  private
  def self.strip_cia_numbers(num_text)
    factor = get_factor(num_text)
    num_text = num_text.gsub(/ (.+est\.).*/,"")
    num_text = num_text.gsub(/[,$%]/,"")
    return num_text.to_f * factor
  end

  def self.get_factor(num_text)
    if num_text =~ /trillion/
      return 1000000000000
    elsif num_text =~ /billion/
      return 1000000000
    else
      return 1
    end
  end
end