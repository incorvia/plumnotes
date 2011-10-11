class UsersController < ApplicationController

  before_filter :authenticate, :only => [:show]

  def new
    @title = 'Sign Up'
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = "My Notes"

    if @user == @current_user
      @note = Notecard.new
      @notecards = feed
      @tags = current_user.tags.group("tag_name")
    else
      redirect_to user_path(@current_user)
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      welcome
      redirect_to @user
    else
      @title = 'Sign Up'
      render 'new'
    end
  end

  def feed
    @user.notecards.sortdesc.page params[:page]
  end

private

  def welcome
    @note = current_user.notecards.create(:content => 
      "Welcome to your new note-taking application! \n \n A few helpful points:  When creating a note, type \"Shift + Enter\" to enter a line break.  To save your note just hit \"enter\".  Tags can be entered by preceding a word with a \"@\" symbol like: @welcome.  
      \n \n
      Enjoy your new found productivity!" )
    @note.tags.create(:tag_name => "@welcome")
    @note.save
  end

end