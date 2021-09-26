class Participants::CalendarView < ::CalendarView


  def attendance_list(reservation)
    %Q{<br>Onsite spots open: <b>#{reservation.onsite_space_remaining}</b> <small>(taken: #{reservation.onsite_attendance_count}; limit: #{reservation.onsite_limit})</small>}
  end

  def attendance_type(reservation, participant = @attendee)
    Attendance.find_by(reservation_id: reservation.id, participant_id: participant.id)
              &.location || "-"
  end

  def attending_on_date?(date, reservations, participant = @attendee)
    return false if reservations.empty?

    reservation_ids = reservations.select{ |r| r.date_range.include?(date) }.map(&:id)
    return false if reservation_ids.empty?

    Attendance.where(reservation_id: reservation_ids, participant_id: participant.id)
              .any?
  end

  def attending?(reservation, participant = @attendee)
    Attendance.where(reservation_id: reservation.id, participant_id: participant.id)
              .any?
  end

  def attending_onsite?(reservation, participant = @attendee)
    Attendance.where(location: 'onsite', reservation_id: reservation.id, participant_id: participant.id)
              .any?
  end

  def attending_remote?(reservation, participant = @attendee)
    Attendance.where(location: 'remote', reservation_id: reservation.id, participant_id: participant.id)
              .any?
  end

  def attend_onsite_url(reservation)
    url_helpers.participants_attendance_path(reservation_id: reservation, location: 'onsite')
  end

  def attend_remote_url(reservation)
    url_helpers.participants_attendance_path(reservation_id: reservation, location: 'remote')
  end

  def attend_delete_url(reservation)
    url_helpers.participants_attendance_path(reservation_id: reservation, location: 'delete')
  end

end
