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
      redirect_to @user
    else
      @title = 'Sign Up'
      render 'new'
    end
  end

  def feed
    @user.notecards.order('notecards.created_at DESC').page params[:page]
  end

private

  def authenticate
    deny_access unless signed_in?
  end 



end