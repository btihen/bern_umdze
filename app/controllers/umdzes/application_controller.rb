# https://railsapps.github.io/rails-authorization.html
class Umdzes::ApplicationController < ApplicationController
  before_action :umdze_only #, :except => :show

  private

  def umdze_only
    unless current_user.access_role == 'umdze'
      redirect_to :back, :alert => "Access denied."
    end
  end

end
