class Participants::CalendarView < CalendarView

  def date_item_class_string(date, reservations = [])
    strings = ["modal-button"]
    strings << "is-today"   if date == today
    strings << "is-active"  if date_has_reservation?(date, reservations)
    if date_has_cancelled_event?(date, reservations)
      strings << "has-cancelled"
    elsif date_attending?(date, reservations)
      strings << "is-attending"
    # elsif date_has_notice?(date, reservations)
    #   strings << "has-notice"
    end
    strings.join(" ")
  end

  def date_attending?(date, reservations)

  end

  def attend_onsite_button_html(reservation)
    %Q{ <a class="button is-primary is-small"
            href="#{url_helpers.participants_attendance_path(reservation_id: reservation,
                                                              location: 'onsite')}">
          Attend On-Site
        </a>
      }
  end

  def attend_remote_button_html(reservation)
    %Q{ <a class="button is-info is-small"
            href="#{url_helpers.participants_attendance_path(reservation_id: reservation,
                                                              location: 'remote')}">
          Attend Remotely
        </a>
      }
  end

  def delete_attend_button_html(reservation)
    %Q{ <a class="button is-danger is-pulled-right is-small is-outlined"
            href="#{url_helpers.participants_attendance_path(reservation_id: reservation,
                                                              location: 'none')}">
          Remove Attendance
        </a>
      }
  end


end
