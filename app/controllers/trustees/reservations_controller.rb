class Trustees::ReservationsController < Trustees::ApplicationController

  def new
    space            = Space.find_by(id: params[:space_id]) || Space.first
    date             = params[:date].to_s.to_date || Date.today # will crash if date invalid
    end_time         = Time.parse("#{(Time.now + 2.hour).hour}:00", date)
    start_time       = Time.parse("#{(Time.now + 1.hour).hour}:00", date)

    user_view        = UserView.new(current_user)
    events_views     = EventView.collection(Event.all)
    spaces_views     = SpaceView.collection(Space.all)

    new_params       = {space_id: space.id,
                        start_date: date, end_date: date,
                        start_time: start_time, end_time: end_time }
    # pre-build associated objects
    reservation      = Reservation.new(new_params)
    reservation_form = Trustees::ReservationForm.new_from(reservation)

    render :new, locals: {user: user_view,
                          events: events_views,
                          spaces: spaces_views,
                          reservation: reservation_form}
  end

  def create
    # Rails models understand how to assemble date_forms
    # "start_date(1i)"=>"2015", "start_date(2i)"=>"1", "start_date(3i)"=>"10", "start_time(1i)"=>"2020", "start_time(2i)"=>"10", "start_time(3i)"=>"5", "start_time(4i)"=>"00", "start_time(5i)"=>"00", "end_date(1i)"=>"2015", "end_date(2i)"=>"1", "end_date(3i)"=>"10", "end_time(1i)"=>"2020", "end_time(2i)"=>"10", "end_time(3i)"=>"5", "end_time(4i)"=>"00", "end_time(5i)"=>"10"
    # silly hack until I build nicer date forms (and fix above problem - or inherit the right methods)
    # allow fields to be cleared (don't remove blank fields)
    create_params    = reservation_params.transform_values(&:squish)
    form_params      = reservation_form_params.transform_values(&:squish)  # hmmm - types aren't working properly

    reservation      = Reservation.new(create_params)
    reservation_form = Trustees::ReservationForm.new_from(reservation)
    reservation_form.assign_attributes(form_params)
binding.pry
    if reservation_form.valid?
      reservation    = reservation_form.reservation
      show_date      = reservation.start_date.to_s
      reservation.save!

      flash[:notice] = "#{reservation.event.event_name} event was successfully reserved."
      redirect_to root_path(date: show_date)

    else
      user_view      = UserView.new(current_user)
      events_views   = EventView.collection(Event.all)
      spaces_views   = SpaceView.collection(Space.all)

      flash[:alert]  = 'Please fix the errors'
      render :new, locals: {user: user_view,
                            events: events_views,
                            spaces: spaces_views,
                            reservation: reservation_form}
    end
  end

  def edit
    reservation      = Reservation.find(params[:id])
    reservation_view = ReservationView.new(reservation)

    user_view        = UserView.new(current_user)
    space_view       = SpaceView.new(reservation.space)
    event_view       = EventView.new(reservation.event)
    spaces_views     = SpaceView.collection(Space.all)
    events_views     = EventView.collection(Event.all)

    render :edit, locals: { user: user_view,
                            space: space_view,
                            event: event_view,
                            spaces: spaces_views,
                            events: events_views,
                            reservation: reservation,
                            reservation_view: reservation_view }
  end

  def update
    reservation      = Reservation.find_by(id: params[:id])
    reservation_view = ReservationView.new(reservation)

    update_params    = reservation_params.transform_values(&:squish)
    reservation.assign_attributes(update_params)

    # no submodels involved (hence no form_object)
    if reservation.save
      show_date   = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully updated."
      redirect_to root_path(date: show_date)

    else
      user_view        = UserView.new(current_user)
      event_view       = EventView.new(reservation.event)
      space_view       = SpaceView.new(reservation.space)
      spaces_views     = SpaceView.collection(Space.all)
      events_views     = EventView.collection(Event.all)

      flash[:alert] = 'Please fix the errors'
      render :edit, locals: { user: user_view,
                              event: event_view,
                              space: space_view,
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
