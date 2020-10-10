class Managers::ReservationsController < Managers::ApplicationController

  def index

  end

  def new
    date             = params[:date].to_s.to_date || Date.today # will crash if date invalid
    end_time         = Time.parse("#{(Time.now + 2.hour).hour}:00", date)
    start_time       = Time.parse("#{(Time.now + 1.hour).hour}:00", date)
    space            = Space.find_by(id: params[:space_id])
    new_params       = {space: space,
                        start_date: date, end_date: date,
                        start_time: start_time, end_time: end_time}
    reservation_form = Managers::ReservationForm.new(new_params)

    render :new, locals: {reservation: reservation_form,
                          events: EventView.collection(Event.all),
                          spaces: SpaceView.collection(Space.all)}
  end

  def create
    reservation_form = Managers::ReservationForm.new(reservation_form_params)
    reservation      = reservation_form.reservation

    if reservation_form.valid? && reservation.save
      show_date      = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} event on #{show_date} was successfully reserved."
      redirect_to root_path(date: show_date)

    else
      flash[:alert]  = 'Please fix the errors'
      render :new, locals: {reservation: reservation_form,
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
    # dup to keep original info incase info is emptied
    reservation_view = ReservationView.new(reservation.dup)

    update_params    = reservation_params.transform_values(&:squish)
    reservation.assign_attributes(update_params)

    if reservation.save
      show_date      = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully updated."
      redirect_to root_path(date: show_date)

    else
      flash[:alert]  = 'Please fix the errors'
      render :edit, locals: { reservation: reservation,
                              reservation_view: reservation_view,
                              events: EventView.collection(Event.all),
                              spaces: SpaceView.collection(Space.all) }
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    show_name   = reservation.event.event_name
    show_date   = reservation.start_date.to_s
    reservation.destroy

    redirect_to root_path(date: show_date), notice: "Reservation #{show_name} on #{show_date} was successfully deleted."
  end

  private

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation)
          .permit(:start_date, :end_date, :start_time, :end_time,
                  :event_id, :event_name, :event_description,
                  :host_name, :is_cancelled, :alert_notice,
                  :space_id, :space_name, :space_location,
                  :frequency_every, :frequency_unit,
                  :frequency_ordinal, :frequency_weekday,
                  :repeat_booking_id)
  end

  # https://hashrocket.com/blog/posts/datetime-select-in-cucumber
  # https://stackoverflow.com/questions/7430343/ruby-easiest-way-to-filter-hash-keys
  def reservation_form_params
    form_params = reservation_params.transform_values(&:squish)
                                    .slice( :host_name, :is_cancelled, :alert_notice,
                                            :space_id, :space_name, :space_location,
                                            :event_id, :event_name, :event_description,
                                            :frequency_every, :frequency_unit,
                                            :frequency_ordinal, :frequency_day,
                                            :repeat_booking_id )
    # in controller - this should work too:
    # https://stackoverflow.com/questions/13605598/how-to-get-a-date-from-date-select-or-select-date-in-rails
    # form_params[:start_date] = Date.new(*params[:start_date].sort.map(&:last).map(&:to_i))
    form_params[:start_date] = Date.new(reservation_params["start_date(1i)"].to_i,
                                        reservation_params["start_date(2i)"].to_i,
                                        reservation_params["start_date(3i)"].to_i)
    # form_params[:end_date]   = Date.new(*params[:end_date].sort.map(&:last).map(&:to_i))
    form_params[:end_date]   = Date.new(reservation_params["end_date(1i)"].to_i,
                                        reservation_params["end_date(2i)"].to_i,
                                        reservation_params["end_date(3i)"].to_i)
    # form_params[:start_time] = Time.new(*params[:start_time].sort.map(&:last).map(&:to_i))
    form_params[:start_time] = Time.new(reservation_params["start_time(1i)"].to_i,
                                        reservation_params["start_time(2i)"].to_i,
                                        reservation_params["start_time(3i)"].to_i,
                                        reservation_params["start_time(4i)"].to_i,
                                        reservation_params["start_time(5i)"].to_i)
    # form_params[:end_time]   = Time.new(*params[:end_time].sort.map(&:last).map(&:to_i))
    form_params[:end_time]   = Time.new(reservation_params["end_time(1i)"].to_i,
                                        reservation_params["end_time(2i)"].to_i,
                                        reservation_params["end_time(3i)"].to_i,
                                        reservation_params["end_time(4i)"].to_i,
                                        reservation_params["end_time(5i)"].to_i)
    form_params
  end

end
