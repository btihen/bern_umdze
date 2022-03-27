# frozen_string_literal: true

module Hosts
  class CalendarView < Users::CalendarView
    def edit_button_html(reservation)
      %( <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_hosts_reservation_path(reservation)}">
          Edit
        </a>
      )
    end
  end
end
