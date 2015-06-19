json.array!(@history_record_datapoints) do |history_record_datapoint|
  json.extract! history_record_datapoint, :id, :history_record_id, :dp_field, :dp_value
  json.url history_record_datapoint_url(history_record_datapoint, format: :json)
end
