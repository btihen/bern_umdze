class Planners::HomeController < Planners::ApplicationController

  def index
    spaces        = Space.all
    attendance      = current_user
    date          = params[:date].nil? ? Date.today : params[:date].to_s.to_date

    user_view     = ::UserView.new(attendance)
    space_views   = ::SpaceView.collection(spaces)
    calendar_view = Planners::CalendarView.new(attendance, date)

    render :index, locals: {user_view: user_view,
                            spaces_view: space_views,
                            calendar_view: calendar_view}
  end

end
