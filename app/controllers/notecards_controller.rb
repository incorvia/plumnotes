class NotecardsController < ApplicationController

  def create
  	@note =  current_user.notecards.build(params[:notecard])
  	@tag_array = tagify(@note.content)
  	if @note.save
      update_note_tags(@tag_array, @note)
  		redirect_to user_path(@current_user)
  	end
  end

  def destroy
  end

  def tagify(note)
		array = note.split
		processed = array.find_all{|item| item =~ /^@\w+/}
  end

  def update_note_tags(tag_list, note)
    delete_tags unless @note.tags.empty?
    assign_tags(tag_list, note)
  end
  
  def delete_tags
    @note.tags.delete_all()
  end

  def assign_tags(tag_list, note)
    tag_list.each do |tag|
      if @note.tags.find_by_tag_name(tag).nil?
        @note.tags.create(:tag_name => tag)
      else
        tag_id = @note.tags.find_by_tag_name(tag).id
        @note.associations.create(:tag_id => tag_id)
      end
    end
  end
end
