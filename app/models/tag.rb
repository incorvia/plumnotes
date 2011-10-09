class Tag < ActiveRecord::Base
	
	has_many :associations
	has_many :notecards, 	:through => :associations

end
