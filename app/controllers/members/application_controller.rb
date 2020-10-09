# https://railsapps.github.io/rails-authorization.html
class Members::ApplicationController < ApplicationController
  before_action :member_only #, :except => :show

  private

  def member_only
    unless current_user.access_role == 'member'
      redirect_back fallback_location: root_path, :alert => "Access denied."
    end
  end

end
