class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update, :index_golfed]
  before_action :set_course, only: [:show, :edit, :destroy, :update]
  before_action :modify_course_permission, only: [:edit, :destroy, :update]

  def index
    @courses = Course.paginate(page: params[:page], per_page: 15)
  end

  def index_golfed
    @courses = current_user.courses.paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def index_created
    @courses = current_user.created_courses.paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.created_courses.create(course_params)
    error_check('new')
  end

  def show
  end

  def edit
  end

  def update
    @course.update(course_params)
    error_check('edit')
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course succesfully deleted."
  end

  private

  def set_course
    @course = Course.find_by(id: params[:id])
    redirect_to courses_path, alert: "Sorry. That course does not exist." if @course.nil?
  end

  def modify_course_permission
    redirect_to courses_path, alert: "Sorry. You can only modify courses you've created." if @course.creator_id != current_user.id
  end

  def error_check(view)
    if @course.valid?
      redirect_to course_path(@course)
    else
      flash.now[:alert] = @course.errors.full_messages.join(', ')
      render view 
    end
  end

  def course_params
    params.require(:course).permit(:name, :city, :state, :access, :style)
  end

end
