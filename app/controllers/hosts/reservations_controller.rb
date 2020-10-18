class Hosts::ReservationsController < Hosts::ApplicationController

  def edit
    reservation      = Reservation.find(params[:id])
    reservation_view = ReservationView.new(reservation)

    render :edit, locals: { reservation: reservation,
                            reservation_view: reservation_view }
  end

  def update
    reservation      = Reservation.find_by(id: params[:id])
    # want the original for event/ space name (for titles)
    # dup to keep original info in case info is emptied
    reservation_view = ReservationView.new(reservation.dup)

    update_params = reservation_params.compact.transform_values(&:squish)
    reservation.assign_attributes(update_params)

    # no submodels involved (hence no form_object)
    if reservation.save
      show_date   = reservation.start_date.to_s

      flash[:notice] = "#{reservation.event.event_name} on #{show_date} was successfully updated."
      redirect_to root_path(date: show_date)

    else
      flash[:alert] = 'Please fix the errors'
      render :edit, locals: { reservation: reservation,
                              reservation_view: reservation_view }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation)
            .permit(:host_name, :space_id, :is_cancelled, :alert_notice,
                    :start_date, :end_date, :start_time, :end_time)
            .to_h
    end
end
