require 'net/http'
require 'json'

class TripAdvisorDetailsService
  API_KEY = '31F1D298D5DA49DFA60DF0E02D40849F'
  BASE_URL = 'https://api.content.tripadvisor.com/api/v1/location/'

  def initialize(location_id)
    @location_id = location_id
  end

  def fetch_details
    url = URI("#{BASE_URL}#{@location_id}/details?language=en&currency=USD&key=#{API_KEY}")

    response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      http.request(request)
    end

    JSON.parse(response.body)
  rescue StandardError => e
    { error: e.message }
  end
end
