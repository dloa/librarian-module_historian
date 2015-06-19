class AddTxnOnHistoryRecord < ActiveRecord::Migration
  def change
    add_column :history_records , :txn_id, :text
  end
end
