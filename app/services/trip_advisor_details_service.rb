require 'net/http'
require 'json'

class TripAdvisorDetailsService
  
  BASE_URL = 'https://api.content.tripadvisor.com/api/v1/location/'

  def initialize(location_id)
    @location_id = location_id
  end

  def fetch_details
    url = URI("#{BASE_URL}#{@location_id}/details?language=en&currency=USD&key=#{api_key}")

    response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      http.request(request)
    end

    JSON.parse(response.body)
  rescue StandardError => e
    { error: e.message }
  end
  private

  def api_key
    ENV['TRIPADVISOR_API_KEY']
  end
end
