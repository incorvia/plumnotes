require 'spec_helper'

describe UsersController do
  render_views

  describe "Get 'show' user page" do                          # ----- User Pages ------   
  
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should return user page" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should show correct user " do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should show the users notes" do
      note1 = Factory(:notecard, :content => "foobar", :user => @user)
      note2 = Factory(:notecard, :content => "foobaz", :user => @user)
      get :show, :id => @user
      response.should have_selector("table#notecard", :content => "foobar")
      response.should have_selector("table#notecard", :content => "foobaz")
    end
  end
  
  describe "GET 'new' user page" do              # ----- Signup Pages ------   
  
    it "should return new page successfully" do
      get 'new'
      response.should be_success
    end
  
    it "should have the correct title" do
      get 'new'
      response.should have_selector("title", :content => "Notes | Sign Up")
    end
    
    describe "failure" do
    
      before(:each) do
        @attr = {:email => "", 
               :password => "", :password_confirmation => ""}
      end
    
      it "should fail when post on empty" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
     
      it "should have the correct title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign Up")
      end
  
      it "should also render the correct page" do
        post :create, :user => @attr
        response.should render_template('new')    
      end
    end
    
    describe "success" do
    
      before(:each ) do
        @attr = {:email => "user@test.org", 
               :password => "foobar", :password_confirmation => "foobar"}
      end
      
      it "should create a new user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should sign in the new user" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
      
      it "should redirect to the right user" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end  
  end

  describe "Authentication" do              # ----- Authentication ------   

    before(:each) do
      @user = Factory(:user)
      @user2 = Factory(:user, :email => "second@user.com")
    end

    describe "for not-signed-in users" do

      it "should redirect a user to the homepage" do
        get :show, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "for signed-in users" do

      it "should not allow access to other users pages" do
        test_sign_in(@user)
        get 'show', :id => @user2
        response.should redirect_to(user_path(@user))
      end
    end
  end
end

