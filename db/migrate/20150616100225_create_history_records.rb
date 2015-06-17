class CreateHistoryRecords < ActiveRecord::Migration
  def change
    create_table :history_records do |t|
      t.text :title
      t.text :http_api_address
      t.text :fields_to_store
      t.string :rate
      t.boolean :public
      t.integer :historian_id

      t.timestamps null: false
    end
  end
end
