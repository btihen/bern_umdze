class Umdzes::CalendarView < CalendarView

  def edit_button_html(reservation)
    %Q{ <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_umdzes_reservation_path(reservation)}">
          Edit
        </a>
      }
  end

end
