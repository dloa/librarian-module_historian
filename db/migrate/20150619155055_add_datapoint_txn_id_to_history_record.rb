class AddDatapointTxnIdToHistoryRecord < ActiveRecord::Migration
  def change
    add_column :history_records , :data_point_txn_id, :text
  end
end
