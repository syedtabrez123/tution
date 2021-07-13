class Tutor < ApplicationRecord
	belongs_to :course, optional: true
end
