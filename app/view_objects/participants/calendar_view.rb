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

  def show_onsite_attend_button?(reservation, participant = @attendee)
    reservation.onsite_space_available? &&
      !reservation.is_cancelled? &&
        (reservation.end_date >= Date.today)
  end

  def show_remote_attend_button?(reservation, participant = @attendee)
    !reservation.is_cancelled? &&
      (reservation.end_date >= Date.today)
  end

  def show_remove_attend_button?(reservation, participant = @attendee)
    !reservation.is_cancelled? &&
      (reservation.end_date >= Date.today)
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

  def attend_onsite_button_html(reservation)
    %Q{<a class="button is-primary is-small is-light is-outlined#{' is-inverted' if attending_onsite?(reservation)}"
          title="Attend On-Site"
          #{href="#{url_helpers.participants_attendance_path(reservation_id: reservation, location: 'onsite')}" unless attending_onsite?(reservation)}
          #{'disabled' if attending_onsite?(reservation)}>
          Attend On-Site
      </a>
    }
  end

  def attend_remote_button_html(reservation)
    %Q{<a class="button is-info is-small is-light is-outlined#{' is-inverted' if attending_remote?(reservation)}"
          title="Attend Remotely"
          #{href="#{url_helpers.participants_attendance_path(reservation_id: reservation, location: 'remote')}" unless attending_remote?(reservation)}
          #{'disabled' if attending_remote?(reservation)}>
          Attend Remotely
      </a>
    }
  end

  def delete_attend_button_html(reservation)
    %Q{ <a class="button is-danger is-pulled-right is-small is-light is-outlined#{' is-inverted' unless attending?(reservation)}"
          #{'disabled' unless attending?(reservation)}
          #{href="#{url_helpers.participants_attendance_path(reservation_id: reservation, location: 'none')}" if attending?(reservation)}>
          Remove Attendance
        </a>
      }
  end


end
