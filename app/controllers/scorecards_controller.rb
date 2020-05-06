class ScorecardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

end
