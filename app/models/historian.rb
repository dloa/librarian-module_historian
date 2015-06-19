class Historian < ActiveRecord::Base
  ### Associations ###
  has_many :history_records
  #####

  ### Validations ###
  validate :send_to_florincoin
  validates :name, :address, :txn_id, :bit_msg_address, presence: true
  validates :txn_id, uniqueness: true
  ####

  ### CallBacks
  #before_save :send_to_florincoin
  ####

  # private
  #Object Methods, Initialize Rpc calls and send transition with tx-comment
  def send_to_florincoin
    florincoin_client = FlorincoinRPC.new()
    signature = florincoin_client.signmessage(address, "#{name}-#{address}-#{Time.now.to_i}")
    tx_comment = '{"alexandria-historian": {  "name": "'+"#{name}"+'", "address": "'+"#{address}"+'", "timestamp": "'+"#{Time.now.to_i}"+'", "bitcoin": "'+"#{bit_msg_address}"+'", "bitmessage": ""}, "signature": "'+"#{signature}"+'"}'
    self.txn_id = florincoin_client.sendtoaddress(address, 0.01, "", "", tx_comment)
    errors.add(:txn_id, 'Transaction is not generated.') if self.txn_id.blank?
  end

end
