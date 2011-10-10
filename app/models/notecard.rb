class Notecard < ActiveRecord::Base

	attr_accessible :content

	belongs_to	:user

	has_many :associations
	has_many :tags, 	:through => :associations

	validates  :content,	:length => { :maximum => 1000 }
	validates	 :user_id,	:presence => true 

	scope		:sortdesc,  order('notecards.created_at DESC')
	scope 	:notes_with_tag, lambda { |tag| return_notes_with_tag(tag) }

private

	def self.return_notes_with_tag(tag)
		 joins(:tags).where(:tags => {:tag_name => "#{tag}"}).order('notecards.created_at DESC')
	end

end
