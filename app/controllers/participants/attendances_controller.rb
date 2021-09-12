class Participants::AttendancesController < Participants::ApplicationController
  # before_action :set_attendance, only: %i[ show edit update destroy ]

  # using edit since I can't find an easy / clear way to inject a form or button as text
  def edit
    # participant = set_participant
    attendance = set_attendance(attendance_params) || Attendance.new
    attendance.assign_attributes attendance_params
    reservation = Reservation.find attendance_params[:reservation_id]
    event_display = "#{reservation.event.event_name} on #{reservation.start_date}"

    # none - is how to remove
    if delete? && attendance.destroy
      redirect_to participants_home_path, notice: "Attendance removed for #{event_display}."

    # elsif delete? && !attendance.persisted? && attendance.destroy
    #   redirect_to participants_home_path, notice: "Attendance removed for #{event_display}."

    # elsif delete? && attendance.persisted? && attendance.destroy
    #   redirect_to participants_home_path, notice: "Attendance removed for #{event_display}."

    elsif remote? && attendance.present? && attendance.valid? && attendance.save
      redirect_to participants_home_path, notice: "#{attendance_params[:location].capitalize} attendance for #{event_display}."

    elsif onsite? && onsite_limit_ok?(reservation) && attendance.present? && attendance.valid? && attendance.save
      redirect_to participants_home_path, notice: "#{attendance_params[:location].capitalize} attendance for #{event_display}."

    else
      redirect_to participants_home_path, alert: "OOPS - unexpected error for event #{}."
    end
  end

  private

    def delete?
      !ApplicationHelper::LOCATIONS.include? attendance_params[:location]
    end

    def onsite?
      attendance_params[:location].eql?('onsite')
    end

    def remote?
      attendance_params[:location].eql?('remote')
    end

    def onsite_limit_ok?(reservation)
      reservation.onsite_space_available?
      # onsite_attendance_count = reservation.onsite_attendances.count
      # onsite_space_limit = reservation.space.onsite_limit
      # onsite_attendance_count < onsite_space_limit
    end

    def set_attendance(attendance_attributes)
      Attendance.find_by attendance_params.without(:location)
      # participant_id = session[:participant][:id]
      # Attendance.find_by(participant_id: participant_id,
      #                    reservation_id: attendance_params[:reservation_id])

    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      { location: params[:location],
        reservation_id: params[:reservation_id],
        participant_id: session[:participant]["id"],
      }
    end
end
