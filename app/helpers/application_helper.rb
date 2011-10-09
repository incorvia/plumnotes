module ApplicationHelper
  
  def title
    base_title = "Notes"
    @title.blank? ? base_title : base_title + ' | ' + @title
  end
  
end
