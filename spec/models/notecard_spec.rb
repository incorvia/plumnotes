require 'spec_helper'

describe Notecard do

	before(:each) do
		@user = Factory(:user)
		@attr = {:content => "This is the first note"}
	end
  
  it "should create a new instace given valid attributes" do
  	@user.notecards.create!(@attr)
  end

  describe "notecard associations" do

  	before(:each) do
  		@notecard = @user.notecards.create!(@attr)
  	end

  	it "should respond to a user attribute" do
  		@notecard.should respond_to(:user)
  	end

  	it "should have the right associated user" do
  		@notecard.user_id.should == @user.id
  		@notecard.user.should == @user
  	end
  end

  describe "notecard validations" do

  	before(:each) do
  		@note = @user.notecards.build
  	end

    it "should have a maximum length of 1000 characters" do
      @note.content = "a" * 1001
      @note.should_not be_valid
    end

    it "should require a user_id" do
      Notecard.new(@attr).should_not be_valid
    end
  end
end
