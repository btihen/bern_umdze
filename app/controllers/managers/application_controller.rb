# frozen_string_literal: true

# https://railsapps.github.io/rails-authorization.html
module Managers
  class ApplicationController < ::Users::ApplicationController
    before_action :manager_only # , :except => :show

    private

    def manager_only
      unless current_user.access_role == 'manager' # || current_user.access_role == 'trustee'
        redirect_back fallback_location: landing_path, alert: 'Access denied.'
      end
    end
  end
end
