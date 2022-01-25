class ReservationView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :reservation,      :root_model

  # delegate to model for attributes needed
  delegate  :start_date_time, :end_date_time, :start_date, :end_date, :is_cancelled?,
            :onsite_space_available?, :onsite_space_remaining, :onsite_attendance_count,
            to: :reservation

  def onsite_limit
    reservation.space.onsite_limit
  end

  def event_name
    event.event_name
  end
  def event
    EventView.new(reservation.event)
  end

  def space_name
    space.space_name
  end
  def space
    SpaceView.new(reservation.space)
  end

  # methods for attribuits
  def alert_notice
    reservation.alert_notice || ""
  end
  # alias_method :change_notice, :alert_notice

  def host_name
    @host_name ||= reservation.host_name || ""
  end

  def remote_link
    @remote_link ||= reservation.remote_link || ""
  end

  def remote_info
    @remote_info ||= reservation.remote_info || ""
  end

  def date_range_string
    @date_range_string ||=
      if is_event_one_day?
        "#{start_date_time.strftime("%a %e.%b")} (#{start_date_time.strftime("%H:%M")} - #{end_date_time.strftime("%H:%M")})"
      else
        "#{start_date_time.strftime("%a %e.%b (%H:%M)")} - #{end_date_time.strftime("%a %e.%b (%H:%M)")}"
      end
  end

  def date_range
    @date_range ||= (start_date .. end_date)
  end

  def is_event_one_day?
    return true   if start_date == end_date
    false
  end

  def is_multi_day_event?
    return true   if (end_date - start_date).to_i > 0
    false
  end

  def is_range_start?(date)
    return true   if is_multi_day_event? && (date == start_date)
    false
  end

  def is_range_end?(date)
    return true   if is_multi_day_event? && (date == end_date)
    false
  end
end
