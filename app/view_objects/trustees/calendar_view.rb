class Trustees::CalendarView < CalendarView

  def new_button_html(space, date)
    %Q{ <a class="button is-success"
          href="#{url_helpers.new_trustees_reservation_path(space_id: space.id,
                                                        date: display_date(date))}">
          Add Reservation
        </a>
      }
  end

  def edit_button_html(reservation)
    %Q{ <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_trustees_reservation_path(reservation)}">
          Edit
        </a>
      }
  end

end
