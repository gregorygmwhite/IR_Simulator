require 'factbook'
require_relative 'countries.rb'

countries = CountryList.get_country_list
countries["all"].each do |country_code|
  page = Factbook::Page.new( country_code )
  File.open( "countries_data/#{country_code}.json", 'w') do |f|
    f.write page.to_json( pretty: true )
  end
end 