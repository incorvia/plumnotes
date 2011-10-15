class NotecardsController < ApplicationController

  before_filter :authenticate, :only => [:update]
  before_filter :authorized_user, :only => [:destroy, :update]

  def create
  	@note =  current_user.notecards.build(params[:notecard])
  	if @note.save
      @tag_array = tagify(@note.content)
      add_note_tags(@tag_array, @note)
  		redirect_to user_path(@current_user)
  	end
  end

  def destroy
    if signed_in?
      @note.destroy
      redirect_to user_path(@current_user)
    end
  end

  def update
    if @note.update_attributes(params[:notecard])
      @tag_array = tagify(@note.content)
      update_note_tags(@tag_array, @note)
      redirect_to user_path(@current_user)
    else
      redirect_to edit_notecard_path(@note)
    end
  end

  def edit
    @note = Notecard.find_by_id(params[:id])
  end

  def tagify(note)
		array = note.split
		processed = array.find_all{|item| item =~ /^@\w+/}
  end

  def add_note_tags(tag_list, note)
    delete_tags(note) unless note.tags.empty?
    assign_tags(tag_list, note)
  end

  def update_note_tags(tag_list, note)
    delete_tags(note) unless note.tags.empty?
    assign_tags(tag_list, note)
  end
  
  def delete_tags(note)
    note.tags.delete_all()
  end

  def assign_tags(tag_list, note)
    tag_list.each do |tag|
      if current_user.tags.find_by_tag_name(tag).nil?
        note.tags.create(:tag_name => tag)
      else
        tag_id = current_user.tags.find_by_tag_name(tag).id
        note.associations.create(:tag_id => tag_id)
      end
    end
  end

private

  def authorized_user
    @note = Notecard.find(params[:id])
    redirect_to root_path unless current_user?(@note.user)
  end

end
