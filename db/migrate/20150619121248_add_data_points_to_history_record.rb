class AddDataPointsToHistoryRecord < ActiveRecord::Migration
  def change
    add_column :history_records , :data_points, :text
  end
end
