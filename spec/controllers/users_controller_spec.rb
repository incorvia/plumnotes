require 'spec_helper'

describe UsersController do
  render_views

  describe "User pages" do                          # ----- User Pages ------   
  
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should return user page" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should " do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
  
  describe "User new (signup) page" do              # ----- Signup Pages ------   
  
    it "should return new page successfully" do
      get 'new'
      response.should be_success
    end
  
    it "should have the correct title" do
      get 'new'
      response.should have_selector("title", :content => "Notes | Sign Up")
    end
  end
end
