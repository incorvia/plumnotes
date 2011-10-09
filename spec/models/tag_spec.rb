require 'spec_helper'

describe Tag do
  
  describe "tag associations" do

  	before(:each) do
  		@note = Factory(:notecard, :user_id => 1)
  		@note2 = Factory(:notecard, :user_id => 2)
  		@tag1 = @note.tags.create(:tag_name => "foobar")
  	end

  	it "should respond to notecards" do
  		@tag1.should respond_to(:notecards)
  	end

  	it "should have the correct notes" do
  		@tag1.notecards.should include(@note)
  	end

  	it "should not include incorrect notes" do
  		@tag1.notecards.should_not include(@note2)
  	end

  end
end
