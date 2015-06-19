class CreateHistoryRecordDatapoints < ActiveRecord::Migration
  def change
    create_table :history_record_datapoints do |t|
      t.integer :history_record_id
      t.string :dp_field
      t.string :dp_value

      t.timestamps null: false
    end
  end
end
