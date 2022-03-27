# frozen_string_literal: true

module Managers
  class ReservationsCreateError < StandardError; end
end

module Managers
  class ReservationsCreateCommand
    # helpful for debugging
    attr_reader :form, :reservation, :repeat_booking

    def initialize(reservation_form)
      @form            = reservation_form
      @reservation     = reservation_form.reservation
      @repeat_booking  = reservation_form.repeat_booking
    end

    def self.call(_reservation_form)
      new(repeat_bookings_form).run
    end

    # always return a truthy for success and raise error when doesn't work (or a falsy if a soft error is possible)
    def run
      raise Managers::ReservationsCreateError, form.errors.messages.to_s unless form.valid?

      reservation.save

      if repeat_booking.present? && form.repeat_every.positive?
        Managers::RepeatBookingsCreateCommand.new(repeat_booking).run
      end

      reservation
    end
  end
end
