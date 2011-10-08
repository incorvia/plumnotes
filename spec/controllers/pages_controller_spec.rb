require 'spec_helper'

describe PagesController do
  render_views
  
  describe "Home Pages" do                          # ----- Home Page ------              
    
    it "should get Home successfully" do
      get 'home'
      response.should be_success
    end

    it "should have the correct title" do
      get 'home'
      response.should have_selector("title", :content => "Notes | Home")
    end

    describe "when signed in" do
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end      

      it "should redirect to the users page" do
        get 'home'
        response.should redirect_to(user_path(@user))
      end
    end
  end
end
