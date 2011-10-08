class NotecardsController < ApplicationController

  def create
  	@note =  current_user.notecards.build(params[:notecard])  
  	if @note.save
  		redirect_to user_path(@current_user)
  	end
  end

  def destroy
  end

end
