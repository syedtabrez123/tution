class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :tutors
end
