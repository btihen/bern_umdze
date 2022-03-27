# frozen_string_literal: true

# https://railsapps.github.io/rails-authorization.html
module Hosts
  class ApplicationController < ::Users::ApplicationController
    before_action :host_only # , :except => :show

    private

    def host_only
      unless current_user.access_role == 'host' # || current_user.access_role == 'umdze'
        redirect_back fallback_location: landing_path, alert: 'Access denied.'
      end
    end
  end
end
