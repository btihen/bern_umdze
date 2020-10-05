class Trustees::ReservationsController < Trustees::ApplicationController

  def new
    user          = current_user
    date          = params[:date].to_s.to_date || Date.today # will crash if date invalid
    space         = Space.find_by(id: params[:space_id]) || Space.first
    spaces        = Space.all
    events        = Event.all

    user_view     = UserView.new(user)
    events_views  = EventView.collection(events)
    spaces_views  = SpaceView.collection(spaces)

    end_time      = Time.parse("#{(Time.now + 2.hour).hour}:00")
    start_time    = Time.parse("#{(Time.now + 1.hour).hour}:00")

    reservation   = Reservation.new(start_date: date, end_date: date, space_id: space.id,
                                    start_time: start_time, end_time: end_time)
    reservation_form = Trustees::ReservationForm.new_from(reservation)

    render :new, locals: {user: user_view,
                          events: events_views,
                          spaces: spaces_views,
                          reservation: reservation_form}
  end

  def create
    user          = current_user
    spaces        = Space.all
    events        = Event.all

    user_view     = UserView.new(user)
    events_views  = EventView.collection(events)
    spaces_views  = SpaceView.collection(spaces)

    # Rails models understand how to assemble date_forms
    # "start_date(1i)"=>"2015", "start_date(2i)"=>"1", "start_date(3i)"=>"10", "start_time(1i)"=>"2020", "start_time(2i)"=>"10", "start_time(3i)"=>"5", "start_time(4i)"=>"00", "start_time(5i)"=>"00", "end_date(1i)"=>"2015", "end_date(2i)"=>"1", "end_date(3i)"=>"10", "end_time(1i)"=>"2020", "end_time(2i)"=>"10", "end_time(3i)"=>"5", "end_time(4i)"=>"00", "end_time(5i)"=>"10"
    # silly hack until I build nicer date forms (and fix above problem - or inherit the right methods)
    reservation   = Reservation.new(reservation_params)
    reservation_form = Trustees::ReservationForm.new_from(reservation)
    reservation_form.assign_attributes(reservation_form_params)
    # reservation_form = Trustees::ReservationForm.new(reservation_form_params)

    if reservation_form.valid?
      reservation = reservation_form.reservation
      reservation.save!

      flash[:notice] = "#{reservation.event.event_name} event was successfully reserved."
      redirect_to root_path
    else
      flash[:alert] = 'Please fix the errors'
      render :new, locals: {user: user_view,
                            events: events_views,
                            spaces: spaces_views,
                            reservation: reservation_form}
    end
  end

  def edit
    user          = current_user
    reservation   = Reservation.find(params[:id])
    space         = Space.find_by(id: reservation.space_id)
    spaces        = Space.all
    event         = Event.find_by(id: reservation.event_id)

    user_view     = UserView.new(user)
    event_view    = EventView.new(event)
    space_view    = SpaceView.new(space)
    spaces_views  = SpaceView.collection(spaces)
    reservation_view = ReservationView.new(reservation)
    # reservation_form = Umdzes::ReservationForm.new_from(reservation)

    render :edit, locals: { user: user_view,
                            event: event_view,
                            space: space_view,
                            spaces: spaces_views,
                            reservation: reservation,
                            reservation_view: reservation_view }
  end

  def update
    user          = current_user
    reservation   = Reservation.find_by(id: params[:id])
    space         = Space.find_by(id: reservation.space_id)
    spaces        = Space.all
    event         = Event.find_by(id: reservation.event_id)

    user_view     = UserView.new(user)
    event_view    = EventView.new(event)
    space_view    = SpaceView.new(space)
    spaces_views  = SpaceView.collection(spaces)
    reservation_view = ReservationView.new(reservation)

    # udpated_attrs = reservation_params.merge(id: params[:id])
    # reservation   = Umdzes::ReservationForm.new(udpated_attrs)
    reservation.assign_attributes(reservation_params)

    # no submodels involved (hence no form_object)
    if reservation.save
      flash[:notice] = "#{reservation.event.event_name} event was successfully updated."
      redirect_to root_path
    else
      flash[:alert] = 'Please fix the errors'
      render :edit, locals: { user: user_view,
                              event: event_view,
                              space: space_view,
                              spaces: spaces_views,
                              reservation: reservation,
                              reservation_view: reservation_view }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation)
            .permit(:host_name, :space_id, :space_name, :space_location,
                    :start_date, :end_date, :start_time, :end_time,
                    :event_id, :is_cancelled, :alert_notice)
    end
    def reservation_form_params
      params.require(:reservation)
            .permit(:host_name, :space_id, :space_name, :space_location,
                    :event_id, :event_name, :event_description,
                    # :start_date, :end_date, :start_time, :end_time,
                    :is_cancelled, :alert_notice)
    end
end
