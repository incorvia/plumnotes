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
      @note = Notecard.new if signed_in?
      @notecards = @user.notecards.page params[:page]
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

private

  def authenticate
    deny_access unless signed_in?
  end 

end