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
                              .map { |person| "#{person.real_name} - #{person.email}" }
    onsite_names += Attendance.joins(:participant)
                              .includes(:participant)
                              .where(reservation_id: reservation.id)
                              .where(location: 'onsite')
                              .map(&:participant)
                              .map { |person| "#{person.fullname} - #{person.email}" }
                              # .map(&:fullname)
    remote_names  = Attendance.joins(:user)
                              .includes(:user)
                              .where(reservation_id: reservation.id)
                              .where(location: 'remote')
                              .map(&:user)
                              .map { |person| "#{person.real_name} - #{person.email}" }
                              # .map(&:real_name)
    remote_names += Attendance.joins(:participant)
                              .includes(:participant)
                              .where(reservation_id: reservation.id)
                              .where(location: 'remote')
                              .map(&:participant)
                              .map { |person| "#{person.fullname} - #{person.email}" }
                              # .map(&:fullname)
    if (onsite_names + remote_names).blank?
      %Q{ <br>
          <b>Teilnehmer:</b> (0 von #{reservation.onsite_limit})
      }
    elsif onsite_names.blank?
      %Q{ <br>
          <b>vor Ort Teilnehmer:</b> (0 von #{reservation.onsite_limit})
          <br>
          <b>Zoom Teilnehmer:</b> (#{remote_names.count})<br>
          <small>
            * #{remote_names.compact.join("<br>* ")}
          </small>
        }
    elsif remote_names.blank?
      %Q{ <br>
          <b>vor Ort Teilnehmer:</b> (#{onsite_names.count} of #{reservation.onsite_limit})<br>
          <small>
            * #{onsite_names.compact.join("<br>* ")}
          </small>
          <br>
          <b>Zoom Teilnehmer:</b> (0)
        }
    else
      %Q{ <br>
          <b>vor Ort Teilnehmer:</b> (#{onsite_names.count} of #{reservation.onsite_limit})<br>
          <small>
            * #{onsite_names.compact.join("<br>* ")}
          </small>
          <br>
          <b>Zoom Teilnehmer:</b> (#{remote_names.count})<br>
          <small>
            * #{remote_names.compact.join("<br>* ")}
          </small>
        }
    end
  end

  def zoom_link_display(reservation)
    return "" if reservation.remote_link.blank?

    display_html = "<strong><a target='_blank' href='#{reservation.remote_link}'>#{reservation.remote_link}</a></strong>"

    attendance_count = Attendance.where(reservation_id: reservation.id).count

    if attendance_count.positive?
      display_html += %Q{
                        <a class="button is-info is-pulled-right is-small is-light is-outlined"
                          title="send Zoom-Link"
                          href='#{url_helpers.users_send_remote_links_path(reservation_id: reservation.id)}'>
                          Zoom-Link senden
                        </a>
                      }
    end

    display_html
  end

  def attendance_type(reservation, user = @attendee)
    Attendance.find_by(reservation_id: reservation.id, user_id: user.id)
              &.location || ""
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
