class Api::V1::CoursesController < ApplicationController
	before_action :set_course, only: [:show]

	def index
		@courses = Course.includes(:tutors)
		json_response(@courses, [:tutors])
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			json_response(@course, [:tutors], :created)
		else
			json_response(@course.errors, [], :bad_request)
		end	
	end

	def show
		json_response(@course, [:tutors])
	end	

	private

	def course_params
		params.require(:course).permit(:title, tutors_attributes: [:id, :name])
	end

	def set_course
		@course = Course.find(params[:id])
	end	
end
