require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'signup'" do
    it "should be successful" do
      get 'signup'
      response.should be_success
    end
  end
  
  describe "Get 'title'" do
    it "should have the correct title" do
      get 'home'
      response.should have_selector("title", :content => "Notes | Home")
    end
  end
  
  describe "Get 'title'" do
    it "should have the correct title" do
      get 'signup'
      response.should have_selector("title", :content => "Notes | Sign Up")
    end
  end
  
  
end
