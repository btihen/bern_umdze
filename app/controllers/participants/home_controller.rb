# frozen_string_literal: true

module Participants
  class HomeController < Participants::ApplicationController
    def index
      spaces = Space.all
      attendance = set_participant
      date = params[:date].nil? ? Date.today : params[:date].to_s.to_date

      attendance_view = ::ParticipantView.new(attendance)
      space_views      = ::SpaceView.collection(spaces)
      calendar_view    = Participants::CalendarView.new(attendance, date)

      render :index, locals: { participant: attendance,
                               user_view: attendance_view,
                               spaces_view: space_views,
                               calendar_view: }
    end

    private

    def set_participant
      current_participant(session[:login_token])
    end
  end
end
