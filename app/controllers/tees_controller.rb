class TeesController < ApplicationController
  before_action :set_course
  def new
    set_course
    @tee = @course.tees.new
    18.times do
      @tee.holes.build
    end
  end

  def create

  end

  private

  def set_course
    @course = Course.find_by(id: params[:course_id])
    redirect_to courses_path, alert: "Sorry. That course does not exist." if @course.nil?
  end

end
