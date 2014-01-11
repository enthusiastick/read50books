require 'spec_helper'

describe Book do

  describe "Database Tests" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:author).of_type(:string) }
    it { should have_db_column(:date_completed).of_type(:datetime) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  describe "Validation Tests" do
    it { should have_valid(:title).when("Blah blah") }
    it { should_not have_valid(:title).when(nil, "") }
    it { should have_valid(:author).when("Blah blah") }
    it { should_not have_valid(:author).when(nil, "") }
    it { should have_valid(:date_completed).when("2014-1-11") }
    it { should_not have_valid(:date_completed).when(nil, "") }
  end

  # describe "Association Tests" do
  #   it { should belong_to(:user) }
  #   it { should have_many(:game_traits) }
  #   it { should have_many(:characters) }
  # end

end
