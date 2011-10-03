require 'spec_helper'

describe 'Users' do

  describe 'user signup' do

	describe 'failure' do

	  it "should not make a new user" do
		lambda do
		  visit signup_path
			fill_in "user_email",  	:with => ""
			fill_in "user_password", :with => ""
			fill_in "user_password_confirmation", :with => ""
			click_button("I'm Ready")
			response.should render_template('users/new')
			response.should have_selector("div.error")
		  end.should_not change(User, :count)
		end
	  end

	describe 'success' do

	  it "should not make a new user" do
	    lambda do
		  visit signup_path
		  fill_in "user_email",  	:with => "test@user.com"
		  fill_in "user_password", :with => "password"
		  fill_in "user_password_confirmation", :with => "password"
		  click_button("I'm Ready")
		  response.should render_template('users/show')
		end.should change(User, :count).by(1)
	  end
    end
  end
end
