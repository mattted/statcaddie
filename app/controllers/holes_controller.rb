class HolesController < ApplicationController
  def show
    unless (@hole = Hole.find_by(id: params[:id]))
      redirect_to root_path, alert: "Sorry. Could not find a hole with that ID."
    end
  end
end
