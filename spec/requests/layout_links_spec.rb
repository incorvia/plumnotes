require 'spec_helper'

describe "LayoutLinks" do
  
  describe "GET /layout_links" do               # ----- Layout Links -----
    
    it "should have 'home' at '/'" do
      get '/'
      response.should have_selector("title", :content => "Notes | Home")
    end
    
    it "should have 'signup' at '/signup'" do   
      get '/signup'
      response.should have_selector("title", :content => "Notes | Sign Up")
    end
  end
  
  describe "Visit /layout_links" do               # ----- Visit Links -----
    
    it "should correctly visit '/signup' from homepage link" do
      visit '/'
      click_link 'Sign Up!'
      response.should have_selector("title", :content => "Notes | Sign Up")
    end
  
    it "should correctly visit '/' from header link" do
      visit '/signup'
      click_link 'Notes'
      response.should have_selector("title", :content => "Notes | Home")
    end
  
  end
end
