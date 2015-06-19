class HistoryRecord < ActiveRecord::Base
  ### Associations ###
  belongs_to :historian
  #####

  ### Validations ###
  validate :send_to_florincoin
  validates :title, :http_api_address, :fields_to_store, :rate, :public, presence: true
  validates :txn_id, uniqueness: true
  ####

  private
  #Object Methods, Initialize Rpc calls and send transition with tx-comment
  def send_to_florincoin
    historian = Historian.where(id: historian_id).first
    if historian.present?
      florincoin_client = FlorincoinRPC.new()
      signature = florincoin_client.signmessage(address, "#{title}-#{historian.address}-#{Time.now.to_i}")
      tx_comment = '{"alexandria-history-record": {  "title": "'+"#{title}"+'", "address": "'+"#{historian.address}"+'", "timestamp": "'+"#{Time.now.to_i}"+'", "api": "'+"#{http_api_address}"+'", "fields": "'+"#{fields_to_store}"+'", "rate": "'+"#{rate}"+'" }, "signature": "'+"#{signature}"+'"}'
    end
    self.txn_id = florincoin_client.sendtoaddress(address, 0.01, "", "", tx_comment)
    errors.add(:txn_id, 'Transaction is not generated.') if self.txn_id.blank?
  end
end
