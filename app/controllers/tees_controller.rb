class TeesController < ApplicationController
  before_action :set_course, only: [:new, :create]
  before_action :set_tee, only: [:edit, :destroy, :update, :show]
  before_action :modify_tee_permission, except: [:new, :show]

  def new
    set_course
    @tee = @course.tees.new
    modify_tee_permission

    # TODO: call a second time with more params
    # (probably need JS event listener to do automatically)
    18.times do
      @tee.holes.build
    end
  end

  def create
    set_course
    @tee = @course.tees.create(tee_params)
    error_check('new')
  end

  def edit
  end

  def update
    @tee.update(tee_params)
    error_check('edit')
  end

  def destroy
    course = @tee.course
    @tee.destroy
    redirect_to course_path(course), notice: "Successfully deleted."
  end

  private

  def tee_params
    params.require(:tee).permit(:color, holes_attributes: [:id, :hole_number, :par, :yardage])
  end

  def set_course
    @course = Course.find_by(id: params[:course_id])
    redirect_to courses_path, alert: "Sorry. That course does not exist." if @course.nil?
  end

  def set_tee
    @tee = Tee.find_by(id: params[:id])
    redirect_to root_path, alert: "Sorry. That tee does not exist." if @tee.nil?
  end

  def modify_tee_permission
    redirect_to course_path(@tee.course), alert: "Sorry. You can only modify courses you've created." if @tee.course.creator_id != current_user.id
  end

  def error_check(view)
    if @tee.valid?
      redirect_to course_path(@tee.course), notice: "Tee succesfully added."
    else
      flash.now[:alert] = @tee.errors.full_messages.join(', ')
      render view
    end
  end

end
