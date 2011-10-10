class Notecard < ActiveRecord::Base

	attr_accessible :content

	belongs_to	:user

	has_many :associations
	has_many :tags, 	:through => :associations

	validates  :content,	:length => { :maximum => 1000 }
	validates	 :user_id,	:presence => true 


end
