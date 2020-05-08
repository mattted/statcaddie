class RoundsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @rounds = Round.paginate(page: params[:page], per_page: 15)
  end

  def index_user
    @rounds = current_user.rounds.paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def index_course
    @rounds = Round.where(Round.arel_table[:course_id]
      .in(current_user.created_courses.pluck(:id)))
      .paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def create
    @round = Round.create(round_params)
    if @round.valid?
      params[:round][:holes].to_i.times do |i|
        @round.scorecards.build(hole_number: i+1)
      end
      render 'scorecards'
    else
    end
  end

  def show
    set_round
  end

  def edit
    set_round
  end

  def update
    set_round
    @round.update(round_params)
    if @round.valid?
      redirect_to round_path(@round)
    else
      error_check('edit')
    end
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
      redirect_to home_path, alert: "Could not find a round with that ID."
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

end
