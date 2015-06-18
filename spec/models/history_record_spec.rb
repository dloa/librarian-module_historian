require "rails_helper"
RSpec.describe HistoryRecord, :type => :model do

  ### we have check association for HistoryRecord ###
  it { should belong_to(:historian)}

end