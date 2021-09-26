class Managers::CalendarView < Users::CalendarView

  def new_button_html(space, date)
    %Q{ <a class="button is-success"
            href="#{url_helpers.new_managers_reservation_path(space_id: space.id, date: date.to_s)}">
          Add Reservation
        </a>
      }
  end

  def edit_button_html(reservation)
    %Q{ <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_managers_reservation_path(reservation)}">
          Manage
        </a>
      }
  end

  def delete_button_html(reservation)
    ""
    # %Q{ <a class="button is-danger is-pulled-right"
    #         data-method=”delete”
    #         href="#{url_helpers.managers_reservation_path(reservation)}">
    #       Delete
    #     </a>
    #   }
    # %Q{ <%= link_to "Delete",
    #               managers_reservation_path(reservation),
    #               method: :delete, confirm: "Are you sure?",
    #               class: "button is-danger is-pulled-right" %>
    #   }
  end

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

end
