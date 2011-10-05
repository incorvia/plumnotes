require 'spec_helper'

describe UsersController do
  render_views

  describe "Get 'show' user page" do                          # ----- User Pages ------   
  
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
      
      it "should redirect to the right user" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end  
  end
end

