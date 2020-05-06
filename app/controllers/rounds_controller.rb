class RoundsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

  def new
    @course = Course.new
  end

  def factory
    binding.pry
  end
end
