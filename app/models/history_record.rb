class HistoryRecord < ActiveRecord::Base
  ### Associations ###
  belongs_to :historian
  has_many :history_record_datapoints
  #####

  ### Validations ###
  validates :title, :http_api_address, :fields_to_store, :rate, :public, presence: true
  validates :txn_id, uniqueness: true
  ####

  ### Callbacks ###
  before_save :save_data_fields
  ####

  # serialize field is for data points on the header for history records
  serialize :data_points, Hash

  #Object Methods, Initialize Rpc calls and send transition with tx-comment
  def send_to_florincoin
    historian = Historian.where(id: historian_id).first
    if historian.present?
      florincoin_client = FlorincoinRPC.new()
      signature = "ar"#florincoin_client.signmessage(historian.address, "#{title}-#{historian.address}-#{Time.now.to_i}")
      tx_comment =  { "alexandria-history-record" => {  "title" => "#{title}",
                                                      "address" => "#{historian.address}",
                                                      "timestamp" => "#{Time.now.to_i}",
                                                      "api" => "#{http_api_address}",
                                                      "fields"=> "#{fields_to_store}",
                                                      "rate" => "#{rate}"
                                                      },
                      "signature"=> "#{signature}"
                    }.to_json
      self.txn_id = "as"#florincoin_client.sendtoaddress(historian.address, 0.01, "", "", tx_comment)
    end
    errors.add(:txn_id, 'Transaction is not generated.') if self.txn_id.blank?
  end


  private

    # This method will save the fields from the history revcord form
    def save_data_fields
      data_fields = FlorincoinRPC.new(self.http_api_address)
      data_points = data_fields.get_data
      self.data_points =  data_points
    end

end


