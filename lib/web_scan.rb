require 'net/http'

module WebScan
  def self.web_vulnerability_scan(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    puts "Scanning #{url}..."
    puts "Response code: #{response.code}"
  end
end
