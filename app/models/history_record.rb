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
  after_save :save_data_fields
  ####


  #Object Methods, Initialize Rpc calls and send transition with tx-comment
  def send_to_florincoin
    historian = Historian.where(id: historian_id).first
    if historian.present?
      florincoin_client = FlorincoinRPC.new()
      signature = florincoin_client.signmessage(historian.address, "#{title}-#{historian.address}-#{Time.now.to_i}")
      tx_comment =  { "alexandria-history-record" => {  "title" => "#{title}",
                                                      "address" => "#{historian.address}",
                                                      "timestamp" => "#{Time.now.to_i}",
                                                      "api" => "#{http_api_address}",
                                                      "fields"=> "#{fields_to_store}",
                                                      "rate" => "#{rate}"
                                                      },
                      "signature"=> "#{signature}"
                    }.to_json
      self.txn_id = florincoin_client.sendtoaddress(historian.address, 0.01, "", "", tx_comment)
    end
    errors.add(:txn_id, 'Transaction is not generated.') if self.txn_id.blank?
  end

  
  private

    # This method will save the fields from the history revcord form
    def save_data_fields
      if fields_to_store.present?
        data_fields = fields_to_store.split(",")
        ActiveRecord::Base.transaction do
          data_fields.each do |f|
            self.history_record_datapoints.create(dp_field: f)
          end
        end
      end
    end
end
