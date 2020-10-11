# frozen_string_literal: true

class Managers::ReservationsCreateError < StandardError; end

class Managers::ReservationsCreateCommand

  # helpful for debugging
  attr_reader :form, :repeat, :reservation

  def initialize(reservation_form)
    @form        = reservation_form
    @repeat      = reservation_form.repeat_hash  #{every: integer, unit: "month", ordinal: "first", day: "saturday", end_date: date}
    @reservation = reservation_form.reservation
  end

  def self.call(reservation_form)
    new(repeat_bookings_form).run
  end

  # always return a truthy for success and falsy for failure
  def run
    raise Managers::ReservationsCreateError(form.errors.messages.to_s)  unless form.valid?

    case repeat[:every]
    when 0, NilClass
      reservation.save
    else
      create_this_
      create_repeat_reservations
      reservation
    end
  end

  private

  def 


end
