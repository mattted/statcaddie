class RoundsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :modify_round_permission, except: [:index, :factory, :index_user, :index_course, :new, :create, :show]

  def index
    @rounds = Round.order(date: :desc).paginate(page: params[:page], per_page: 15)
  end

  def index_user
    @rounds = current_user.rounds.order(date: :desc).paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def index_course
    @rounds = Round.where(Round.arel_table[:course_id]
      .in(current_user.created_courses.pluck(:id))).order(date: :desc)
      .paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def create
    @round = Round.create(round_params)
    if @round.valid?
      18.times do |i|
        @round.scorecards.build(hole_number: i+1)
      end
      render 'scorecards'
    else
      flash.now[:alert] = @round.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
  end

  def edit
    add_holes
  end

  def update
    @round.update(round_params)
    if @round.valid?
      redirect_to round_path(@round)
    else
      error_check('edit')
    end
  end

  def destroy
    @round.destroy
    redirect_to my_rounds_path, notice: "Successfully deleted."
  end

  def factory
    if params[:state].nil?
      render 'form_state'
    elsif params[:state] && params[:city].nil?
      @courses = Course.where(state: params[:state])
      render 'form_city'
    elsif params[:state] && params[:city] && params[:name].nil?
      @courses = Course.where(state: params[:state], city: params[:city])
      render 'form_course'
    elsif params[:state] && params[:city] && params[:name]
      course = Course.find_by(state: params[:state], city: params[:city], name: params[:name])
      @round = current_user.rounds.new(course: course)
      render 'new'
    else
      flash.now[:alert] = "There was an error. Please try again"
      render 'form_state'
    end
  end

  private

  def set_round
    unless @round = Round.find_by(id: params[:id])
      redirect_to rounds_path, alert: "Could not find a round with that ID."
    end
  end

  def error_check(view)
    flash.now[:alert] = @round.errors.full_messages.join(', ')
    render view
  end

  def round_params
    params.require(:round).permit(:course_id, :golfer_id, :date, :tee,
                                  scorecards_attributes: [:fairway, :gir, :hole_number, :notes, :putts, :strokes, :id])
  end

  def add_holes
    (18 - @round.scorecards.count).times do
      @round.scorecards.build
    end
  end

  def modify_round_permission
    redirect_to my_rounds_path, alert: "Sorry. You can only modify rounds you've created." if @round.golfer_id != current_user.id
  end

end
