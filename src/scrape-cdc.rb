require 'net/http'
require 'json'

uri = URI('https://covid.cdc.gov/covid-data-tracker/COVIDData/getAjaxData?id=integrated_county_timeseries_state_FL_external')
data = JSON.parse(Net::HTTP.get(uri))

filtered = data['integrated_county_timeseries_external_data']
    .select { |x| x['county'] == 'Hillsborough County' }
    .sort_by { |x| x['date'] }

File.open('public/hc-cdc.json', 'w') { |f| f.write(filtered.to_json) }