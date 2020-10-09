# https://railsapps.github.io/rails-authorization.html
class Trustees::ApplicationController < ApplicationController
  before_action :trustee_only #, :except => :show

  private

  def trustee_only
    unless current_user.access_role == 'trustee'
      redirect_back fallback_location: root_path, :alert => "Access denied."
    end
  end

end
