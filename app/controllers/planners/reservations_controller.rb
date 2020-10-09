class Planners::ReservationsController < Planners::ApplicationController

  def new
    date         = params[:date].to_s.to_date || Date.today
    end_time     = Time.parse("#{(Time.now + 2.hour).hour}:00", date)
    start_time   = Time.parse("#{(Time.now + 1.hour).hour}:00", date)
    space        = Space.find_by(id: params[:space_id]) || Space.first

    user_view    = UserView.new(current_user)
    events_views = EventView.collection(Event.all)
    spaces_views = SpaceView.collection(Space.all)

    reservation  = Reservation.new( space_id: space.id,
                                    start_date: date, end_date: date,
                                    start_time: start_time, end_time: end_time )

    render :new, locals: {user: user_view,
                          events: events_views,
                          spaces: spaces_views,
                          reservation: reservation}
  end

  def create
    create_params  = reservation_params.transform_values(&:squish)
    reservation    = Reservation.new(create_params)

    if reservation.save
      show_date    = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} event was successfully reserved."
      redirect_to root_path(date: show_date)

    else
      user_view     = UserView.new(current_user)
      events_views  = EventView.collection(Event.all)
      spaces_views  = SpaceView.collection(Space.all)

      flash[:alert] = 'Please fix the errors'
      render :new, locals: {user: user_view,
                            events: events_views,
                            spaces: spaces_views,
                            reservation: reservation}
    end
  end

  def edit
    reservation      = Reservation.find(params[:id])
    reservation_view = ReservationView.new(reservation)

    user_view        = UserView.new(current_user)
    event_view       = EventView.new(reservation.event)
    space_view       = SpaceView.new(reservation.space)
    events_views     = EventView.collection(Event.all)
    spaces_views     = SpaceView.collection(Space.all)

    render :edit, locals: { user: user_view,
                            event: event_view,
                            space: space_view,
                            spaces: spaces_views,
                            events: events_views,
                            reservation: reservation,
                            reservation_view: reservation_view }
  end

  def update
    reservation      = Reservation.find_by(id: params[:id])
    reservation_view = ReservationView.new(reservation)

    update_params = reservation_params.transform_values(&:squish)
    reservation.assign_attributes(update_params)

    if reservation.save
      show_date   = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully updated."
      redirect_to root_path(date: show_date)

    else
      user_view        = UserView.new(current_user)
      event_view       = EventView.new(reservation.event)
      space_view       = SpaceView.new(reservation.space)
      events_views     = EventView.collection(Event.all)
      spaces_views     = SpaceView.collection(Space.all)

      flash[:alert] = 'Please fix the errors'
      render :edit, locals: { user: user_view,
                              event: event_view,
                              space: space_view,
                              events: events_views,
                              spaces: spaces_views,
                              reservation: reservation,
                              reservation_view: reservation_view }
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    show_date   = reservation.start_date.to_s
    reservation.destroy

    redirect_to root_path(date: show_date), notice: 'User was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation)
          .permit(:host_name, :space_id, :event_id,
                  :is_cancelled, :alert_notice,
                  :start_date, :end_date, :start_time, :end_time)
  end

end
