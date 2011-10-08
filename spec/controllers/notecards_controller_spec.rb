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
          post :create, :notecards => @attr
        end.should change(Notecard, :count).by(1)
      end

      it "should redirect to users page" do
        post :create, :notecards => @attr
        response.should redirect_to(user_path(@user))
      end

    end

  end

end
