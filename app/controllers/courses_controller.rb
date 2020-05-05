class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

  def index
    @courses = Course.paginate(page: params[:page], per_page: 15)
  end

  def new
    @course = Course.new
  end

  def create
    binding.pry
  end

  private
  
  def course_params
    params.require(:course).permit(:name, :city, :state, :access, :style)
  end

end
