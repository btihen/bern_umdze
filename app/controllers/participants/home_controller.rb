class Participants::HomeController < Participants::ApplicationController

  def index
    participant   = current_participant(session[:login_token])
    # spaces        = Space.all
    # participant   = current_participant
    # date          = params[:date].nil? ? Date.today : params[:date].to_s.to_date

    # # user_view     = ::UserView.new(user)
    # # space_views   = ::SpaceView.collection(spaces)
    # # calendar_view = ::CalendarView.new(user_view, date)

    render :index, locals: {participant: participant}

    # # render :index, locals: {particpant: participant,
    # #                         spaces_view: space_views,
    # #                         calendar_view: calendar_view}
  end

end
