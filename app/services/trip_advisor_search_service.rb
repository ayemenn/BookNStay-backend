require 'net/http'
require 'json'

class TripAdvisorSearchService
  BASE_URL = 'https://api.content.tripadvisor.com/api/v1/location/search'

  def initialize(query)
    @query = URI.encode_www_form_component(query)
  end

  def search
   # puts "API Key: #{api_key}"
    url = URI("#{BASE_URL}?searchQuery=#{@query}&language=en&key=#{api_key}")

    response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      http.request(request)
    end
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      puts "Error fetching data: #{response.code} - #{response.message}"
      { error: response.body }
    end
  rescue StandardError => e
    { error: e.message }
  end

  private

  def api_key
    ENV['TRIPADVISOR_API_KEY']
  end
end
