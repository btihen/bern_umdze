class Planners::ReservationsController < Planners::ApplicationController

  def new
    date         = params[:date].to_s.to_date || Date.today
    end_time     = Time.parse("#{(Time.now + 2.hour).hour}:00", date)
    start_time   = Time.parse("#{(Time.now + 1.hour).hour}:00", date)
    space        = Space.find_by(id: params[:space_id]) || Space.first

    reservation  = Reservation.new( space_id: space.id,
                                    start_date: date, end_date: date,
                                    start_time: start_time, end_time: end_time )

    render :new, locals: {reservation: reservation,
                          events: EventView.collection(Event.all),
                          spaces: SpaceView.collection(Space.all)}
  end

  def create
    create_params  = reservation_params.transform_values(&:squish)
    reservation    = Reservation.new(create_params)

    if reservation.save
      show_date    = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully created."
      redirect_to root_path(date: show_date)

    else
      flash[:alert] = 'Please fix the errors'
      render :new, locals: {# user: user_view,
                            reservation: reservation,
                            events: EventView.collection(Event.all),
                            spaces: SpaceView.collection(Space.all)}
    end
  end

  def edit
    reservation      = Reservation.find(params[:id])
    reservation_view = ReservationView.new(reservation)

    render :edit, locals: { reservation: reservation,
                            reservation_view: reservation_view,
                            events: EventView.collection(Event.all),
                            spaces: SpaceView.collection(Space.all) }
  end

  def update
    reservation      = Reservation.find_by(id: params[:id])
    # want the original for event/ space name (for titles)
    # dup to keep original info in case info is emptied
    reservation_view = ReservationView.new(reservation.dup)

    update_params = reservation_params.transform_values(&:squish)
    reservation.assign_attributes(update_params)

    if reservation.save
      show_date   = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully updated."
      redirect_to root_path(date: show_date)

    else
      flash[:alert] = 'Please fix the errors'
      render :edit, locals: { reservation: reservation,
                              reservation_view: reservation_view,
                              events: EventView.collection(Event.all),
                              spaces: SpaceView.collection(Space.all) }
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
          .permit(:is_cancelled, :alert_notice,
                  :host_name, :space_id, :event_id,
                  :start_date, :end_date, :start_time, :end_time)
  end

end
