class Association < ActiveRecord::Base

	belongs_to		:tag
	belongs_to		:notecard

end
