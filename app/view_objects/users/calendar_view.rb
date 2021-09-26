class Users::CalendarView < CalendarView

  def date_item_class_string(date, reservations = [])
    strings = ["modal-button"]
    strings << "is-today"   if date == today
    strings << "is-active"  if date_has_reservation?(date, reservations)
    if date_has_cancelled_event?(date, reservations)
      strings << "has-cancelled"
    elsif date_has_event_wo_host?(date, reservations)
      strings << "has-missing-host"
    elsif date_has_notice?(date, reservations)
      strings << "has-notice"
    elsif attending_on_date?(date, reservations)
      strings << "is-attending"
    end
    strings.join(" ")
  end

  def attendance_list(reservation)
    onsite_names  = Attendance.joins(:user)
                              .includes(:user)
                              .where(reservation_id: reservation.id)
                              .where(location: 'onsite')
                              .map(&:user)
                              .map(&:real_name)
    onsite_names += Attendance.joins(:participant)
                              .includes(:participant)
                              .where(reservation_id: reservation.id)
                              .where(location: 'onsite')
                              .map(&:participant)
                              .map(&:fullname)
    remote_names  = Attendance.joins(:user)
                              .includes(:user)
                              .where(reservation_id: reservation.id)
                              .where(location: 'remote')
                              .map(&:user)
                              .map(&:real_name)
    remote_names += Attendance.joins(:participant)
                              .includes(:participant)
                              .where(reservation_id: reservation.id)
                              .where(location: 'remote')
                              .map(&:participant)
                              .map(&:fullname)
    if (onsite_names + remote_names).blank?
      %Q{ <br>
          <b>Attendees:</b>(0)
      }
    elsif onsite_names.blank?
      %Q{ <br>
          <b>Onsite Attendees:</b> (0 of #{reservation.onsite_limit})
          <br>
          <b>Remote Attendees:</b>(#{remote_names.count})<br>
          <small>
            * #{remote_names.compact.join("<br>* ")}
          </small>
        }
    elsif remote_names.blank?
      %Q{ <br>
          <b>Onsite Attendees:</b> (#{onsite_names.count} of #{reservation.onsite_limit})<br>
          <small>
            * #{onsite_names.compact.join("<br>* ")}
          </small>
          <br>
          <b>Remote Attendees:</b> (0)
        }
    else
      %Q{ <br>
          <b>Onsite Attendees:</b> (#{onsite_names.count} of #{reservation.onsite_limit})<br>
          <small>
            * #{onsite_names.compact.join("<br>* ")}
          </small>
          <br>
          <b>Remote Attendees:</b> (#{remote_names.count})<br>
          <small>
            * #{remote_names.compact.join("<br>* ")}
          </small>
        }
    end
  end


  def attendance_type(reservation, user = @attendee)
    Attendance.find_by(reservation_id: reservation.id, user_id: user.id)
              &.location || "-"
  end

  def attending_on_date?(date, reservations, user = @attendee)
    return false if reservations.empty?

    reservation_ids = reservations.select{ |r| r.date_range.include?(date) }.map(&:id)
    return false if reservation_ids.empty?

    Attendance.where(reservation_id: reservation_ids, user_id: user.id)
              .any?
  end

  def attending?(reservation, user = @attendee)
    Attendance.where(reservation_id: reservation.id, user_id: user.id)
              .any?
  end

  def attending_onsite?(reservation, user = @attendee)
    Attendance.where(location: 'onsite', reservation_id: reservation.id, user_id: user.id)
              .any?
  end

  def attending_remote?(reservation, user = @attendee)
    Attendance.where(location: 'remote', reservation_id: reservation.id, user_id: user.id)
              .any?
  end

  def attend_onsite_url(reservation)
    url_helpers.users_attendance_path(reservation_id: reservation, location: 'onsite')
  end

  def attend_remote_url(reservation)
    url_helpers.users_attendance_path(reservation_id: reservation, location: 'remote')
  end

  def attend_delete_url(reservation)
    url_helpers.users_attendance_path(reservation_id: reservation, location: 'delete')
  end
end
