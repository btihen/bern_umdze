class Viewers::HomeController < Viewers::ApplicationController

  def index
    spaces        = Space.all
    attendee      = current_user
    date          = params[:date].nil? ? Date.today : params[:date].to_s.to_date

    user_view     = ::UserView.new(attendee)
    space_views   = ::SpaceView.collection(spaces)
    calendar_view = ::CalendarView.new(attendee, date)

    render :index, locals: {user_view: user_view,
                            spaces_view: space_views,
                            calendar_view: calendar_view}
  end

end
