class RoundsController < ApplicationController
  before_action :authenticate_user!

  def create
    @round = Round.create(round_params)
    params[:round][:holes].to_i.times do |i|
      @round.scorecards.build(hole_number: i+1)
    end
    error_check('form_state')
  end

  def show
    binding.pry 
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

  def round_params
    params.require(:round).permit(:course_id, :golfer_id, :date, :tee,
                                  scorecards_attributes: [:fairway, :gir, :hole_number, :notes, :putts, :strokes, :id])
  end

  def error_check(view = "")
    if @round.valid?
      redirect_to round_path(@round) if view.blank?
      render 'scorecards'
    else
      flash.now[:alert] = @round.errors.full_messages.join(', ')
      render view
    end
  end

end
