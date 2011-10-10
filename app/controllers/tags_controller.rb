class TagsController < ApplicationController
  def index
  end

  def show
  	@tags = Tag.find_by_id(params[:id])
  	@notecards = current_user.notecards.notes_with_tag(@tags.tag_name).page params[:page]
  	@title = @tags.tag_name
  end

end
