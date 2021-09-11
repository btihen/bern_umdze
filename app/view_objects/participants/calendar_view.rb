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

  def edit_button_html(reservation)
    %Q{ <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_participants_attend_path(reservation)}">
          Attend
        </a>
      }
  end

  def date_attending?(date, reservations)

  end

end
