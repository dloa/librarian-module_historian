require 'net/http'
require 'uri'
require 'json'

class FlorincoinRPC
  SERVICE_URL = 'http://arvind:clarion123@192.168.1.126:18322'

  def initialize(service_url=SERVICE_URL)
    @uri = URI.parse(service_url)
  end

  def method_missing(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end

  def http_post_request(post_body)
    http    = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    response = http.request(request).body
    result = response.blank? ? "{}" : response
  end

  class JSONRPCError < RuntimeError; end
end

###################################
# This section can be used if the Ruby code is written separately
# This code is been taken from referece :: https://en.bitcoin.it/wiki/API_reference_(JSON-RPC)
###################################
# if $0 == __FILE__
#   h = FlorincoinRPC.new('http://arvind:clarion123@192.168.1.126:18322')
#   p h.getbalance
#   p h.getinfo
#   #p h.getnewaddress
#   #p h.signmessage(h.getnewaddress, "My test message")
#   #p h.dumpprivkey( h.getnewaddress )
#   # also see: https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_Calls_list
# end