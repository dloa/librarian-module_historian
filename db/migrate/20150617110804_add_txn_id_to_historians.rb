class AddTxnIdToHistorians < ActiveRecord::Migration
  def change
    add_column :historians , :txn_id, :text
  end
end
