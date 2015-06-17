class CreateHistorians < ActiveRecord::Migration
  def change
    create_table :historians do |t|
      t.string :name
      t.text :address
      t.text :btc_tip_address
      t.text :bit_msg_address

      t.timestamps null: false
    end
  end
end
