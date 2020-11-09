class Managers::RepeatBookingsController < Managers::ApplicationController

  def index
    repeats = RepeatBooking.all.includes(:event)

    render :index, locals: {repeat_bookings: repeats}
  end

  def new
    repeat = RepeatBooking.new( start_date: Date.today,
                                end_date: Date.today,
                                start_time: Time.now,
                                end_time: Time.now + 1.hour,
                                repeat_until_date: Date.today + 1.year + 1.day )

    render :new, locals: {repeat_booking: repeat,
                          events: Event.all, spaces: Space.all }
  end

  def create
    create_params = repeat_booking_params.transform_values(&:squish)
    repeat        = RepeatBooking.new(create_params)

    if repeat.save
      Managers::RepeatBookingsCreateCommand.new(repeat).run
      redirect_to managers_repeat_bookings_path,
                  notice: "Repeat Booking for #{repeat.event.event_name} was successfully updated."

    else
      render :new, locals: {repeat_booking: repeat,
                            events: Event.all,
                            spaces: Space.all }
    end
  end

  def edit
    repeat = RepeatBooking.find(params[:id])

    render :edit, locals: { repeat_booking: repeat,
                            events: Event.all,
                            spaces: Space.all }
  end

  def update
    update_params = repeat_booking_params.transform_values(&:squish)
    repeat        = RepeatBooking.find(params[:id])

    if repeat.update(update_params)
      Reservation.where(repeat_booking_id: repeat.id).destroy_all
      Managers::RepeatBookingsCreateCommand.new(repeat).run

      redirect_to managers_repeat_bookings_path,
                  notice: "Repeat Booking for #{repeat.event.event_name} was successfully updated."

    else
      render :edit, locals: { repeat_booking: repeat,
                              events: Event.all,
                              spaces: Space.all }
    end
  end

  def destroy
    repeat = RepeatBooking.find(params[:id])
    name   = repeat.event.event_name
    Reservation.where(repeat_booking_id: repeat.id).destroy_all
    repeat.destroy    # check that delete dependents work!

    redirect_to managers_repeat_bookings_path,
                notice: "Repeat Booking for #{repeat.event.event_name} was successfully deleted."
  end

  private

  def repeat_booking_params
    params.require(:repeat_booking)
          .permit(:space_id, :event_id, :repeat_ordinal,
                  :repeat_every, :repeat_unit,
                  :repeat_choice, :repeat_until_date,
                  :start_date, :end_date,
                  :start_time, :end_time,
                  :host_name, :is_cancelled, :alert_notice)
  end

end