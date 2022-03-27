# frozen_string_literal: true

module Hosts
  class HomeController < Hosts::ApplicationController
    def index
      spaces = Space.all
      attendance = current_user
      date          = params[:date].nil? ? Date.today : params[:date].to_s.to_date

      user_view     = ::UserView.new(attendance)
      space_views   = ::SpaceView.collection(spaces)
      calendar_view = Hosts::CalendarView.new(attendance, date)

      render :index, locals: { user_view:,
                               spaces_view: space_views,
                               calendar_view: }
    end
  end
end
