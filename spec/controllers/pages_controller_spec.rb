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
  end
end
