# https://railsapps.github.io/rails-authorization.html
class Umdzes::ApplicationController < ApplicationController
  before_action :umdze_only #, :except => :show

  private

  def umdze_only
    unless current_user.access_role == 'umdze'
      redirect_back fallback_location: root_path, :alert => "Access denied."
    end
  end

end
