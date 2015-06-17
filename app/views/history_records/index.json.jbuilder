json.array!(@history_records) do |history_record|
  json.extract! history_record, :id, :title, :http_api_address, :fields_to_store, :rate, :public, :historian_id
  json.url history_record_url(history_record, format: :json)
end
