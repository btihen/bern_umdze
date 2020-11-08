# frozen_string_literal: true

class Managers::RepeatBookingsUpdateError < StandardError; end

class Managers::RepeatBookingsUpdateCommand

  attr_reader :repeat_booking

  def initialize(repeat_booking)
    @repeat_booking    = repeat_booking
  end

  def self.call(repeat_booking)
    new(repeat_booking).run
  end

  # always return a truthy for success and falsy for failure
  def run
    raise Managers::RepeatBookingsUpdateError.new(repeat_booking.errors.messages.to_s) unless repeat_booking.valid?

    # delete_old_reservations (complex to figure out what to do if start dates change, etc)
    Reservation.where(repeat_booking_id: repeat_booking.id).destroy_all

    # create new reservations from scratch since all are deleted
    Managers::RepeatBookingsCreateCommand.new(repeat_booking).run

    repeat_booking               # return truthy (or crash)
  end

end
