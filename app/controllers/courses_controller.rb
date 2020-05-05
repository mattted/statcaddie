class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

  def index
    @courses = Course.paginate(page: params[:page], per_page: 15)
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.created_courses.create(course_params)
    if @course.valid?
      redirect_to course_path(@course)
    else
      flash.now[:alert] = @course.errors.full_messages.join(', ')
      render 'new'
    end
  end

  private
  
  def course_params
    params.require(:course).permit(:name, :city, :state, :access, :style)
  end

end
