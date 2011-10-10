require 'spec_helper'

describe NotecardsController do

  describe "POST to 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "A test note" }
      end

      it "should create a notecard" do
        lambda do
          post :create, :notecard => @attr
        end.should change(Notecard, :count).by(1)
      end

      it "should redirect to users page" do
        post :create, :notecard => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end

  describe "Tagify" do

    before(:each) do
      @attr = { :content => "@tag1 Hello World! test@example. @tag2" }
      @user = test_sign_in(Factory(:user))
    end


    it "should return an array of tags of from note text" do
      post :create, :notecard => @attr
      assigns(:tag_array).should == ["@tag1", "@tag2"]
    end

    it "should assign the correct tags" do
      post :create, :notecard => @attr
      @user_tags = []
        @user.tags.each do |tag|
          @user_tags << tag.tag_name
        end
      @user_tags.should == ["@tag1", "@tag2"]
    end

  end
end
