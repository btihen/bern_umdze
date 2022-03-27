# frozen_string_literal: true

class CalendarView
  delegate :url_helpers, to: 'Rails.application.routes'

  # # 1 == Monday & 7 == Sunday
  # def self.day_of_week(date: Date.today)
  #   date.cwday
  # end

  private

  attr_reader :month_begin_date, :month_end_date, :attendee,
              :date_of_interest, :month_number, :today

  public

  attr_reader :year_number, :month_number

  def initialize(attendee, date = Date.today)
    @attendee           = attendee
    @today              = Date.today
    @date_of_interest   = date
    @year_number        = date.year
    @month_number       = date.month
    @month_begin_date   = date.at_beginning_of_month
    @month_end_date     = date.at_beginning_of_month.next_month - 1.day

    raise StandardError  unless date_first_monday.monday?
    raise StandardError  unless date_last_sunday.sunday?
  end

  def prev_month
    Date.new(year_number, month_number, 15) - 1.month
  end

  def next_month
    Date.new(year_number, month_number, 15) + 1.month
  end

  def prev_month_string
    prev_month.strftime('%Y-%m-%d')
  end

  def next_month_string
    next_month.strftime('%Y-%m-%d')
  end

  def display_date(date)
    return '' if date.blank?

    date.strftime('%e.%b.%Y')
  end

  def date_range
    (date_first_monday..date_last_sunday)
  end

  def full_month_name
    I18n.t('date.month_names')[month_number]
  end

  def abbr_month_name
    I18n.t('date.abbr_month_names')[month_number]
  end

  def choose_reservations_modal_header_html(space, date)
    %(<b>#{display_date(date)}</b> im <b>#{space.space_name}</b>)
  end

  def choose_reservations_modal_body_html(space, date, reservations = [])
    %( <section class="modal-card-body">
          <div class="content is-medium has-text-left">
            #{model_reservations_formatting(date, reservations)}
          </div>
          #{new_button_html(space, date)}
        </section>
        <!--
        <footer class="modal-card-foot">
          #{new_button_html(space, date)}
        </footer>
        -->
      )
  end

  def model_reservations_formatting(date, reservations)
    dates_reservations = reservations.select { |r| r.date_range.include?(date) }
                                     .sort_by(&:start_date_time)
    dates_reservations.each_with_index.map do |dr, index|
      event_color_class = if dr.is_cancelled?
                            'has-background-danger-light'
                          elsif index.even?
                            'has-background-light'
                          else
                            'has-background-grey-lighter'
                          end
      %(<div class="#{event_color_class} with-button">
          <dl class="is-medium reservation">
            <dt>
              #{'<big><b>CANCELLED</b></big><br>' if dr.is_cancelled?}
              #{'<strike>' if dr.is_cancelled?}#{dr.date_range_string}#{'</strike>' if dr.is_cancelled?}
              #{edit_button_html(dr)}
              #{delete_button_html(dr)}
            </dt>
            <dd>
              #{'<strike>' if dr.is_cancelled?}
              Event: <big><b>#{dr.event_name}</b></big><br>
              Host: #{host_display(dr)}</br>
              Zoom: #{zoom_link_display(dr)}
              #{'</strike>' if dr.is_cancelled?}
              #{alert_notice(dr)}
              #{attendance_list(dr)}
              <br>
              Art der Beteiligung: <b><small>#{attendance_display(dr)}</small></b>
              #{attendance_buttons(dr)}
            </dd>
          </dl>
        </div>)
    end.join
  end

  def host_display(reservation)
    if reservation.host_name.blank?
      return "<span class='has-background-warning-light'><strong>Kein Umdze/Koordinator</strong></span>"
    end

    "<strong>#{reservation.host_name}</strong>"
  end

  def zoom_link_display(reservation)
    return '<em><small>Der Zoom-Link wird per E-Mail verschickt.</small></em>' if @attendee.is_a? Participant
    return '' if reservation.remote_link.blank?

    "<strong><a target='_blank' href='#{reservation.remote_link}'>#{reservation.remote_link}</a></strong>"
  end

  def attendance_display(reservation)
    attendance = attendance_type(reservation, @attendee)

    case attendance
    when ''
      'nicht angemeldet'
    when 'onsite'
      'angemeldet vor Ort'
    when 'remote'
      'angemeldet via Zoom'
    end
  end

  def attendance_buttons(dr)
    return '' unless include_attend_button?(dr)

    %( <br>
        #{attend_onsite_button_html(dr)}
        #{attend_remote_button_html(dr)}
        #{delete_attend_button_html(dr)}
        <br>
      )
  end

  def attendance_list(_reservation)
    ''
  end

  def new_button_html(_space, _date)
    ''
  end

  def edit_button_html(_reservation_date)
    ''
  end

  def delete_button_html(_reservation_date)
    ''
  end

  def include_attend_button?(reservation)
    !reservation.is_cancelled? && (reservation.end_date >= Date.today)
  end

  def attending?(reservation, attendee = @attendee)
    raise NotImplementedError
  end

  def attending_onsite?(reservation, attendee = @attendee)
    raise NotImplementedError
  end

  def attending_remote?(reservation, attendee = @attendee)
    raise NotImplementedError
  end

  def attend_onsite_button_html(reservation)
    %(<a class="button is-primary is-small is-light is-outlined#{if attending_onsite?(reservation) || !reservation.onsite_space_available?
                                                                   ' is-inverted'
                                                                 end}"
          title="vor Ort"
          #{unless attending_onsite?(reservation) || !reservation.onsite_space_available?
              "href='#{attend_onsite_url(reservation)}'"
            end}
          #{'disabled' if attending_onsite?(reservation) || !reservation.onsite_space_available?}>
          vor Ort
      </a>
    )
  end

  def attend_remote_button_html(reservation)
    %(<a class="button is-info is-small is-light is-outlined#{' is-inverted' if attending_remote?(reservation)}"
          title="via Zoom"
          #{"href='#{attend_remote_url(reservation)}'" unless attending_remote?(reservation)}
          #{'disabled' if attending_remote?(reservation)}>
          via Zoom
      </a>
    )
  end

  def delete_attend_button_html(reservation)
    %( <a class="button is-danger is-pulled-right is-small is-light is-outlined#{unless attending?(reservation)
                                                                                   ' is-inverted'
                                                                                 end}"
          title="absagen"
          #{'disabled' unless attending?(reservation)}
          #{"href='#{attend_delete_url(reservation)}'" if attending?(reservation)}>
          absagen
        </a>
      )
  end

  def alert_notice(reservation_date)
    return '' if reservation_date.alert_notice.blank?

    %( <br>
        <div class="has-notice">
        <strong>Important:<br>#{reservation_date.alert_notice}</strong>
        </div>
      )
  end

  def choose_modal_form(date, reservations = [])
    # show/edit reservations in modal when there are existing reservations
    return 'reservation-details' if date_has_reservation?(date, reservations)

    # return "reservation-details" if reservations.any?{ |r| (r.start_date == date) || (r.end_date == date) }

    'reservation-new' # form to create a new reservation on other days
  end

  def date_item_class_string(date, reservations = [])
    strings = ['modal-button']
    strings << 'is-today'   if date == today
    strings << 'is-active'  if date_has_reservation?(date, reservations)
    if date_has_cancelled_event?(date, reservations)
      strings << 'has-cancelled'
    elsif date_has_event_wo_host?(date, reservations)
      strings << 'has-missing-host'
    elsif date_has_notice?(date, reservations) && attending_on_date?(date, reservations)
      strings << 'has-notice'
    elsif attending_on_date?(date, reservations)
      strings << 'is-attending'
    end
    strings.join(' ')
  end

  def date_item_tooltip_data(date, reservations = [])
    max_tip_length = 15
    return '' if date_without_reservation?(date, reservations)

    strings = []
    strings << reservations.select { |r| r.date_range.include?(date) }
                           .map { |r| r.event_name.truncate(max_tip_length) }
    strings.join("\n") # css hover::after needs 'white-space: pre-wrap;'
  end

  def date_class_string(date, reservations = [])
    return 'calendar-date is-disabled' if date_outside_month?(date)

    reservations_on_date = reservations.select { |r| r.date_range.include?(date) }

    strings = ['calendar-date']
    strings << 'calendar-range' if reservations_on_date.any?(&:is_multi_day_event?)
    strings << 'range-start'    if reservations_on_date.any? { |r| r.is_range_start?(date) }
    strings << 'range-end'      if reservations_on_date.any? { |r| r.is_range_end?(date) }
    strings.join(' ')
  end

  def date_outside_month?(date)
    date.month != month_number
  end

  def date_in_month_of_interest?(date)
    date.month == month_number
  end

  def date_without_reservation?(date, reservations = [])
    !date_has_reservation?(date, reservations)
  end

  def date_has_reservation?(date, reservations = [])
    return false if reservations.blank?

    reservations.any? { |r| r.date_range.include?(date) }
  end

  def date_has_cancelled_event?(date, reservations = [])
    return false if reservations.blank?

    reservations_this_day = reservations.select { |r| r.date_range.include?(date) }
    return false if reservations_this_day.blank?

    reservations_this_day.any?(&:is_cancelled?)
  end

  def date_has_event_wo_host?(date, reservations = [])
    # return false if reservations.blank?
    reservations_this_day = reservations.select { |r| r.date_range.include?(date) }
    # return false if reservations_this_day.blank?
    reservations_this_day.any? { |r| r.host_name.blank? }
  end

  def date_has_notice?(date, reservations = [])
    # return false if reservations.blank?
    reservations_this_day = reservations.select { |r| r.date_range.include?(date) }
    # return false if reservations_this_day.blank?
    !reservations_this_day.all? { |r| r.alert_notice.blank? }
  end

  private

  def date_first_monday
    # days needed to go start on a monday
    month_start_offset = month_begin_date.cwday - 1
    (month_begin_date - month_start_offset.days)
  end

  def date_last_sunday
    # days needed to go until last sunday
    month_end_offset = 7 - month_end_date.cwday
    (month_end_date + month_end_offset.days)
  end
end
