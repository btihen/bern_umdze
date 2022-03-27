# frozen_string_literal: true

module Participants
  class AttendancesController < Participants::ApplicationController
    # using edit since I can't find an easy / clear way to inject a form or button as text
    def edit
      attendance = Attendance.find_by(attendance_params.without(:location)) || Attendance.new
      attendance.assign_attributes attendance_params
      attendance_info = {
        attendance:,
        location: attendance_params[:location],
        reservation: Reservation.find(attendance_params[:reservation_id])
      }
      flash_msg = AttendanceCommand.call(attendance_info)

      if flash_msg
        redirect_to(participants_home_path, flash_msg)
      else
        # log this?
        redirect_to(participants_home_path, alert: 'OOOPS - unexpected error')
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def attendance_params
      {
        location: params[:location],
        reservation_id: params[:reservation_id],
        participant_id: session[:participant]['id']
      }
    end
  end
end
