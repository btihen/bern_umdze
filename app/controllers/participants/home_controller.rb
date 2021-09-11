class Participants::HomeController < Participants::ApplicationController

  def index
    spaces           = Space.all
    attendee         = set_participant
    date             = params[:date].nil? ? Date.today : params[:date].to_s.to_date

    attendee_view    = ::ParticipantView.new(attendee)
    space_views      = ::SpaceView.collection(spaces)
    calendar_view    = Participants::CalendarView.new(attendee, date)

    render :index, locals: {participant: attendee,
                            user_view: attendee_view,
                            spaces_view: space_views,
                            calendar_view: calendar_view}
  end

  private
    def set_participant
      current_participant(session[:login_token])
    end

end
