require "rails_helper"
RSpec.describe Historian, :type => :model do

  ### we have check association for historian ###
  it { should have_many(:history_records)}

  ### matchers for check validation  ###
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:txn_id) }
  it { should validate_presence_of(:bit_msg_address) }
  it { should validate_uniqueness_of(:txn_id) }

end