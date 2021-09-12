class Participants::CalendarView < ::CalendarView

  def date_item_class_string(date, reservations = [])
    strings = ["modal-button"]
    strings << "is-today"   if date == today
    strings << "is-active"  if date_has_reservation?(date, reservations)
    if date_has_cancelled_event?(date, reservations)
      strings << "has-cancelled"
    elsif attending_on_date?(date, reservations)
      strings << "is-attending"
    # elsif date_has_notice?(date, reservations)
    #   strings << "has-notice"
    end
    strings.join(" ")
  end

  def attendance_type(reservation, participant = @attendee)
    Attendance.find_by(reservation_id: reservation.id, participant_id: participant.id)
              &.location.to_s
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
