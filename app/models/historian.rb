class Historian < ActiveRecord::Base
  has_many :history_records
end
