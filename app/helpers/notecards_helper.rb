module NotecardsHelper

def tagify(note)
		array = note.split
		processed = array.find_all{|item| item =~ /^@\w+/}
  end

  def update_note_tags(tag_list)
    delete_tags unless @note.tags.empty?
    assign_tags(tag_list)
  end
  
  def delete_tags
    @note.tags.delete_all()
  end

  def assign_tags(tag_list)
    tag_list.each do |tag|
      a = @note.tags.find_by_tag_name(tag)
      if a.empty?
        @note.tags.create(:tag_name => tag)
      else
        tag_id = @note.tags.find_by_tag_name(tag).id
        @note.associations.create(:tag_id => tag_id)
      end
    end
  end

end
