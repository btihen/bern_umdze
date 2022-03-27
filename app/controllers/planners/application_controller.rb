# frozen_string_literal: true

# https://railsapps.github.io/rails-authorization.html
module Planners
  class ApplicationController < ::Users::ApplicationController
    before_action :planner_only # , :except => :show

    private

    def planner_only
      unless current_user.access_role == 'planner'
        redirect_back fallback_location: landing_path, alert: 'Access denied.'
      end
    end
  end
end
