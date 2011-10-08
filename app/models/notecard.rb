class Notecard < ActiveRecord::Base

	attr_accessible :content

	belongs_to	:user

	default_scope   :order => 'notecards.created_at DESC'

	validates  :content,	:length => { :maximum => 1000 }
	validates	 :user_id,	:presence => true 

end
