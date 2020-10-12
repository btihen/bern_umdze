class Managers::ReservationForm < FormBase

  # alias_method :reservation, :root_model

  # when the model will never already stored then use the following instead:
  # def persisted?
  #   return true  if id.present?
  #   return false
  # end
  delegate :id, :persisted?, to: :reservation,  allow_nil: true

  delegate  :host_name, :event, :space, :repeat_booking,
            :start_date_time, :end_date_time,
            :start_date, :end_date, :start_time, :end_time,
            to: :reservation,  allow_nil: true

  # All the models that are apart of our form should be part attr_accessor.
  # This allows the form to be initialized with existing instances.
  attr_accessor :id, :host_name, :event, :space,
                :start_date, :end_date, :start_time, :end_time,
                :start_date_time, :end_date_time

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Reservation')
  end

  # is user needed / helpful?
  def self.new_from(reservation)
    attribs = {}
    if reservation.present?
      attribs_init = {id: reservation.id,
                      event: reservation.event,
                      space: reservation.space,
                      host_name: reservation.host_name,
                      end_date: reservation.end_date,
                      start_date: reservation.start_date,
                      end_time: reservation.end_time,
                      start_time: reservation.start_time,
                      is_cancelled: reservation.is_cancelled,
                      alert_notice: reservation.alert_notice,
                      end_date_time: reservation.end_date_time,
                      start_date_time: reservation.start_date_time,
                      repeat_booking: reservation.repeat_booking,
                    }
      attribs = attribs.merge(attribs_init)
    end
    new(attribs)
  end

  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  FrequencyUnit = Struct.new(:value, :display_name, keyword_init: true)
  def self.repeat_units_list
    ApplicationHelper::REPEAT_UNITS.map do |units_hash|
      FrequencyUnit.new(units_hash)
    end
  end

  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  FrequencyOrdinal = Struct.new(:value, :display_name, keyword_init: true)
  def self.repeat_ordinals_list
    ApplicationHelper::REPEAT_ORDINALS.map do |units_hash|
      FrequencyOrdinal.new(units_hash)
    end
  end

  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  FrequencyDay = Struct.new(:value, :display_name, keyword_init: true)
  def self.repeat_choices_list
    ApplicationHelper::REPEAT_DAYS.map do |units_hash|
      FrequencyDay.new(units_hash)
    end
  end

  attribute :end_date,            :date, default: Date.today
  attribute :start_date,          :date, default: Date.today
  attribute :repeat_until_date,   :date, default: Date.today + 12.months
  attribute :end_time,            :time, default: Time.parse("#{(Time.now + 3.hours).hour}:00", Time.now)
  attribute :start_time,          :time, default: Time.parse("#{(Time.now + 2.hour).hour}:00", Time.now)
  attribute :end_date_time,       :datetime
  attribute :start_date_time,     :datetime
  attribute :event_id,            :integer
  attribute :space_id,            :integer
  attribute :repeat_booking_id,   :integer
  attribute :repeat_every,        :integer, default: 0
  attrtbute :repeat_choice,       :integer, default: Date.today.day   # should be the day from start_date
  attrtbute :repeat_month,        :integer, default: Date.today.month # should be the month from start_date
  attribute :repeat_unit,         :squished_string
  attribute :repeat_ordinal,      :squished_string
  attribute :repeat_choice,       :squished_string
  attribute :host_name,           :squished_string
  attribute :event_name,          :squished_string
  attribute :event_description,   :squished_string
  attribute :alert_notice,        :trimmed_text
  attribute :is_cancelled,        :boolean, default: false

  validate :validate_space
  validate :validate_event
  validate :validate_reservation
  validate :validate_repeat_booking

  def reservation
    @reservation     ||= assign_reservation_attribs
  end

  def repeat_booking
    @repeat_booking  ||= assign_repeat_attribs
  end

  def event
    @event           ||= assign_event_attribs
  end

  def space
    @space           ||= (Space.find_by(id: space_id) || Space.new)
  end

  def repeat_hash
    { repeat_day:      repeat_day,      # only relevant with choice = date and unit = month
      repeat_month:    repeat_month,    # only relevant with choice = date and unit = year
      repeat_every:    repeat_every,    # repeat every: 1 month, 2 months, ...
      repeat_unit:     repeat_unit,     # year, month, week, day
      repeat_ordinal:  repeat_ordinal,  # first, second, third, fourth, fifth, last, this (date)
      repeat_choice:   repeat_choice,   # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
      repeat_end_date: repeat_end_date, # default one year from today
    }
  end

  private

  def assign_reservation_attribs
    new_reservation = Reservation.find_by(id: id) || Reservation.new

    # update reservation attributes
    new_reservation.event           = event
    new_reservation.space           = space
    new_reservation.repeat_booking  = repeat_booking
    new_reservation.host_name       = host_name
    new_reservation.start_date      = start_date   || attributes["start_date"]
    new_reservation.start_time      = start_time   || attributes["start_time"]
    new_reservation.end_date        = end_date     || attributes["end_date"]
    new_reservation.end_time        = end_time     || attributes["end_time"]
    new_reservation.start_date_time = calculate_start_date_time
    new_reservation.end_date_time   = calculate_end_date_time
    new_reservation.alert_notice    = alert_notice
    new_reservation.is_cancelled    = is_cancelled
    new_reservation
  end

  def assign_repeat_attribs
    return nil   if repeat_every == 0 && repeat_booking_id.blank?
    new_repeat = RepeatBooking.find(repeat_booking_id) || RepeatBooking.new

    # create a new event if no other info available
    new_repeat.repeat_every    = repeat_every
    new_repeat.repeat_unit     = repeat_unit
    new_repeat.repeat_ordinal  = repeat_ordinal
    new_repeat.repeat_choice   = repeat_choice
    new_repeat.repeat_end_date = repeat_end_date

    # template repeat_booking info (original could get deleted)
    new_repeat.event           = event
    new_repeat.space           = space
    new_repeat.repeat_booking  = repeat_booking
    new_repeat.host_name       = host_name
    new_repeat.start_date      = start_date   || attributes["start_date"]
    new_repeat.start_time      = start_time   || attributes["start_time"]
    new_repeat.end_date        = end_date     || attributes["end_date"]
    new_repeat.end_time        = end_time     || attributes["end_time"]
    new_repeat.start_date_time = calculate_start_date_time
    new_repeat.end_date_time   = calculate_end_date_time
    new_repeat.alert_notice    = alert_notice
    new_repeat.is_cancelled    = is_cancelled
    new_repeat
  end

  def assign_event_attribs
    # use incomming event_id if available
    return Event.find(event_id)             if event_id.present?

    # create a new event if no other info available
    new_event = Event.new
    new_event.event_name        = event_name
    new_event.event_description = event_description
    new_event
  end

  def calculate_start_date_time
    date = start_date || attributes["start_date"]
    time = start_time || attributes["start_time"]

    date_start = date.is_a?(String) ? Date.parse(date) : date
    time_start = time.is_a?(String) ? Time.parse(time) : time
    DateTime.new(date_start.year, date_start.month, date_start.day, time_start.hour, time_start.min, 0) #, "ECT")
  end

  def calculate_end_date_time
    date = end_date || attributes["end_date"]
    time = end_time || attributes["end_time"]

    date_end = date.is_a?(String) ? Date.parse(date) : date
    time_end = time.is_a?(String) ? Time.parse(time) : time
    DateTime.new(date_end.year, date_end.month, date_end.day, time_end.hour, time_end.min, 0) #, "ECT")
  end

  def validate_event
    return if event.valid?

    if event_id.blank? && event_name.blank?
      errors.add(:event_id, "must be chosen or created")
    else
      event.errors.each do |attribute_name, desc|
        attribute_sym = attribute_name.to_s.eql?("id") ? :event_id : attribute_name.to_sym
        errors.add(attribute_sym, desc)
      end
    end
  end

  def validate_space
    return if space.valid?

    space.errors.each do |_attribute_name, desc|
      errors.add(:space_id, desc)
    end
  end

  def validate_reservation
    return if reservation.valid?

    reservation.errors.each do |attribute_name, desc|
      next if attribute_name.to_s.eql?("event.event_name") ||
              attribute_name.to_s.eql?("space.space_name") ||
              attribute_name.to_s.eql?("id")  # id should always be valid - but just in case
      errors.add(attribute_name.to_sym, desc)
    end
  end

  def validate_repeat_booking
    return if repeat_booking.nil?
    return if repeat_booking.valid?

    repeat_booking.errors.each do |attribute_name, desc|
      next if attribute_name.to_s.eql?("event.event_name") ||
              attribute_name.to_s.eql?("space.space_name") ||
              attribute_name.to_s.eql?("id")  # id should always be valid - but just in case
      errors.add(attribute_name.to_sym, desc)
    end
  end

end
