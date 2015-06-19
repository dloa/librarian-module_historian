require "rails_helper"
RSpec.describe HistoryRecord, :type => :model do

  ## we have check association for HistoryRecord ###
  it { should belong_to(:historian)}

  ###
  ### matchers for check validation ###
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:http_api_address) }
  it { should validate_presence_of(:fields_to_store) }
  it { should validate_presence_of(:rate) }
  it { should validate_presence_of(:public) }
  it { should validate_uniqueness_of(:txn_id) }

 end