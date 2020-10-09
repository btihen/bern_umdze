class Planners::CalendarView < CalendarView

  def new_button_html(space, date)
    %Q{ <a class="button is-success"
            href="#{url_helpers.new_planners_reservation_path(space_id: space.id, date: date.to_s)}">
          Add Reservation
        </a>
      }
  end

  def edit_button_html(reservation)
    %Q{ <a class="button is-primary is-pulled-right"
            href="#{url_helpers.edit_planners_reservation_path(reservation)}">
          Manage
        </a>
      }
  end

  def delete_button_html(reservation)
    ""
    # %Q{ <a class="button is-danger is-pulled-right"
    #         data-method=”delete”
    #         href="#{url_helpers.planners_reservation_path(reservation)}">
    #       Delete
    #     </a>
    #   }
    # %Q{ <%= link_to "Delete",
    #               planners_reservation_path(reservation),
    #               method: :delete, confirm: "Are you sure?",
    #               class: "button is-danger is-pulled-right" %>
    #   }
  end

end
