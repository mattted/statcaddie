class TeesController < ApplicationController
  before_action :set_course, only: [:new, create]
  before_action :set_tee, only: [:edit, :destroy, :update, :show]

  def new
    set_course
    @tee = @course.tees.new
    18.times do |i|
      @tee.holes.build
    end
  end

  def create
    set_course
    @tee = @course.tees.create(tee_params)
    error_check('new')
  end

  def edit
    set_tee
  end

  def update

  end

  private

  def tee_params
    params.require(:tee).permit(:color, holes_attributes: [:hole_number, :par, :yardage])
  end

  def set_course
    @course = Course.find_by(id: params[:course_id])
    redirect_to courses_path, alert: "Sorry. That course does not exist." if @course.nil?
  end

  def set_tee
    @tee = Tee.find_by(id: params[:id])
    redirect_to root_path, alert: "Sorry. That tee does not exist." if @tee.nil?
  end

  def error_check(view)
    if @tee.valid?
      redirect_to course_path(@course), notice: "Tee succesfully added."
    else
      flash.now[:alert] = @tee.errors.full_messages.join(', ')
      render view 
    end
  end

end
