json.array!(@historians) do |historian|
  json.extract! historian, :id, :name, :address, :btc_tip_address, :bit_msg_address
  json.url historian_url(historian, format: :json)
end
