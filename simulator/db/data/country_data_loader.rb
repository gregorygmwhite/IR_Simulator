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

  def self.get_goodness_data(goodness={})
    filepath = File.expand_path("../raw_datasets/goodness_ranking.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      next if row[0] == "Country"
      goodness[row[0]] = { overall_rank: row[3] , science_rank: row[4], 
      cultural_rank: row[5], peace_security_rank: row[6], 
      world_order_rank: row[7], planet_climate_rank: row[8], 
      prosperity_equality_rank: row[9], health_rank: row[10]}
    end
    return goodness
  end

  def self.get_airforce_data(airforce={})
    filepath = File.expand_path("../raw_datasets/aircraft_data.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      next if row[0] == "Country"
      airforce[row[0]] = { fighters: row[1] , bombers: row[2], 
      helicopters: row[3] }
    end
    return airforce
  end

  def self.get_army_data(army={})
    filepath = File.expand_path("../raw_datasets/troops_data.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      next if row[0] == "Country"
      army[row[0]] = { active_troops: row[1], reserve_troops: row[2],
      paramilitary_troops: row[3]}
    end
    return army
  end

  def self.get_navy_data(navy={})
    filepath = File.expand_path("../raw_datasets/military_equipment_data.csv", __FILE__)
    CSV.foreach(filepath) do |row|
      next if row[0] == "Country"
      navy[row[0]] = { tanks: row[2],  aircraft_carriers: row[3],
        amphibious_ships: row[4],  cruisers: row[5],  destroyers: row[6],
        frigates: row[7], corvettes: row[8], patrol_boats: row[10],
        nuclear_submarines: row[11],submarines: row[12], 
        combat_aircraft: row[13], attack_helicopters: row[14],
        nuclear_weapons:  row[15]}
    end
    debugger
    return navy
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