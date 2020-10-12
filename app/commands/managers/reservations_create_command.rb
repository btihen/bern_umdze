# frozen_string_literal: true

class Managers::ReservationsCreateError < StandardError; end

class Managers::ReservationsCreateCommand

  # helpful for debugging
  attr_reader :form, :repeat, :reservation, :next_date_dalta

  def initialize(reservation_form)
    @form            = reservation_form
    @reservation     = reservation_form.reservation
    @repeat_booking  = reservation_form.repeat_booking
    @next_date_dalta = repeat_bookings.end_date - repeat_booking.start_date
  end

  def self.call(reservation_form)
    new(repeat_bookings_form).run
  end

  # always return a truthy for success and raise error when doesn't work (or a falsy if a soft error is possible)
  def run
    raise Managers::ReservationsCreateError(form.errors.messages.to_s)  unless form.valid?
    # raise Managers::ReservationsCreateError(reservation.errors.messages.to_s)  unless reservation.valid?
    # raise Managers::ReservationsCreateError(repeat_booking.errors.messages.to_s)  unless repeat_booking.valid?

    reservation.save

    if repeat_booking.present? && (form.repeat_every > 0)
      # reservation allows event and space to be created - don't create again!
      repeat_bookings.event = reservation.event
      repeat_bookings.space = reservation.space
      repeat_bookings.save!

      # now that all is saved and validated we can create additional reservations
      create_repeat_reservations
      # Managers::RepeatBookingsCreateCommand.new(repeat_bookings).run
    end

    reservation
  end

  private

  def create_repeat_reservations
    repeat_until_max_date = repeat_booking.repeat_until_date + 1
    next_start_date = calculate_next_date(repeat_booking.start_date)

    while (next_start_date < repeat_until_max_date) do
      next_reservation = build_next_reservation(next_start_date)
      next_reservation.save

      next_start_date  = calculate_next_date(next_start_date)
    end
  end

  def build_next_reservation(start_date)
    booking_params = repeat_booking.attributes
    next_params    = booking_params.slice(:host_name, :alert_notice, :is_cancelled,
                                          :start_time, :end_time, :event_is, :space_id )

    next_params[:start_time] = start_date
    next_params[:end_time]   = start_date + next_date_dalta

    next_reservation = Resevation.new(next_params)
  end

  def calculate_next_date(prior_start_date)
    case repeat_booking.repeat_unit
    when "year"
    when "month"
    end
  end

  # REPEAT_ORDINALS = [
  #   {value: "first",   display_name: "First"},
  #   {value: "second",  display_name: "Second"},
  #   {value: "third",   display_name: "Third"},
  #   {value: "fourth",  display_name: "Fourth"},
  #   {value: "fifth",   display_name: "Fifth"},
  #   {value: "last",    display_name: "Last"},
  #   {value: "this",    display_name: "This (date)"},
  # ]

  # REPEAT_CHOICES = [
  #   {value: "mon",     display_name: "Monday"},
  #   {value: "tue",     display_name: "Tuesday"},
  #   {value: "wed",     display_name: "Wednesday"},
  #   {value: "thu",     display_name: "Thursday"},
  #   {value: "fri",     display_name: "Friday"},
  #   {value: "sat",     display_name: "Saturday"},
  #   {value: "sun",     display_name: "Sunday"},
  #   {value: "day",     display_name: "Day"},
  #   {value: "date",    display_name: "Date"},  # date (choice) must be paired with this (ordinal) - validate
  # ]

end
