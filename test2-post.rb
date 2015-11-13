# This code converts an url to pdf in Ruby using SelectPdf REST API through a POST request. 
# The content is saved into a file on the disk.

require 'net/http'

api_endpoint = 'http://selectpdf.com/api2/convert/'
key = 'your license key here'
test_url = 'http://selectpdf.com'
local_file = 'test.pdf'

parameters = {
	"key" => key,
	"url" => test_url
}

uri = URI(api_endpoint)

Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Post.new uri.request_uri
  request.set_form_data(parameters)

  http.request request do |response|
	if (response.code == '200') then

		# on success - save generated pdf document into a file
		open local_file, 'wb' do |io|
		  response.read_body do |chunk|
			io.write chunk
		  end
		end

		print "Test pdf document generated successfully!\n" 
	else
		
		# error - show response code and message
		print "HTTP Response code: " + response.code + "\n"
		print "HTTP Response message: " + response.message + "\n"
	end
  end
end
