class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def stats
  end

  def index
  end
end
