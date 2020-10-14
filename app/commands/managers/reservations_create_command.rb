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
      Managers::RepeatBookingsCreateCommand.new(repeat_bookings).run
    end

    reservation
  end

end
