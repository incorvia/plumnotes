require 'spec_helper'

describe "HeaderLinks" do

	describe "Logged in header" do

		before(:each) do
			@user = Factory(:user)
			@attr = {:email => @user.email, 
																 :password => @user.password}
			visit signin_path
			fill_in "session_email", :with => @user.email
			fill_in "session_password", :with => @user.password
			click_button "Submit"
		end

		it "should render the 'signedin' partial." do	
			response.should render_template('layouts/_signedin') 
		end

		it "should show user's email address" do
			response.should have_selector("div.topbar", 
																	:content => @user.email)
		end

		it "should have a signout link" do
			response.should have_selector("div.topbar", :content => "Sign Out")
		end

		it "signout link should signout user" do
			click_link "Sign Out"
			controller.current_user.should be_nil
		end
	end

	describe "Logged out header" do

		it "should sign a user in" do
			@user = Factory(:user)
			@attr = {:email => @user.email, 
																 :password => @user.password}
			visit root_url
			fill_in "email_login", :with => @user.email
			fill_in "pass_login", :with => @user.password
			click_button "Sign in"
			controller.current_user.should == @user
			response.should have_selector("title", :content => "My Notes")
		end
	end
end

