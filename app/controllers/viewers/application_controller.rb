# https://railsapps.github.io/rails-authorization.html
class Viewers::ApplicationController < ApplicationController
  before_action :viewer_only #, :except => :show

  private

  def viewer_only
    unless current_user.access_role == 'viewer' || current_user.access_role == 'member'
      redirect_back fallback_location: landing_path, :alert => "Access denied."
    end
  end

end
