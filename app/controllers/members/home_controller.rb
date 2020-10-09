class Members::HomeController < Members::ApplicationController

  def index
    spaces        = Space.all
    user          = current_user
    date          = params[:date].nil? ? Date.today : params[:date].to_s.to_date

    user_view     = ::UserView.new(user)
    space_views   = ::SpaceView.collection(spaces)
    calendar_view = ::CalendarView.new(user_view, date)

    render :index, locals: {user_view: user_view,
                            spaces_view: space_views,
                            calendar_view: calendar_view}
  end

end
