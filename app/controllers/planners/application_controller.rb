# https://railsapps.github.io/rails-authorization.html
class Planners::ApplicationController < ApplicationController
  before_action :planner_only #, :except => :show

  private

  def planner_only
    unless current_user.access_role == 'planner'
      redirect_back fallback_location: root_path, :alert => "Access denied."
    end
  end

end
