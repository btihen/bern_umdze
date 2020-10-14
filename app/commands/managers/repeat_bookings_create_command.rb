# frozen_string_literal: true

class Managers::RepeatBookingsCreateError < StandardError; end

class Managers::RepeatBookingsCreateCommand

  attr_reader :repeat_booking,
              :start_date,     :repeat_unit,    :repeat_every,
              :repeat_choice,  :repeat_ordinal, :repeat_until_date

  def initialize(repeat_booking)
    @repeat_booking    = repeat_booking
    @start_date        = repeat_booking.start_date
    @repeat_unit       = repeat_booking.repeat_unit
    @repeat_every      = repeat_booking.repeat_every
    @repeat_choice     = repeat_booking.repeat_choice
    @repeat_ordinal    = repeat_booking.repeat_ordinal
    @repeat_until_date = repeat_booking.repeat_until_date
  end

  def self.call(repeat_booking)
    new(repeat_booking).run
  end

  # always return a truthy for success and falsy for failure
  def run
    create_repeat_reservations
    repeat_booking              # return truthy (or crash)
  end

  private

  def create_repeat_reservations
    repeat_increment_index = 1
    repeat_until_max_date  = repeat_until_date + 1
    next_start_date        = calculate_next_date(repeat_increment_index)

    while (next_start_date < repeat_until_max_date) do
      next_reservation = build_next_reservation(next_start_date)
      next_reservation.save

      repeat_increment_index += 1
      next_start_date         = calculate_next_date(repeat_increment_index)
    end
  end

  def build_next_reservation(start_date)
    booking_params = repeat_booking.attributes
    next_params    = booking_params.slice(:host_name, :alert_notice, :is_cancelled,
                                          :start_time, :end_time, :event_is, :space_id )
    next_params[:repeat_booking] = repeat_booking
    next_params[:start_time]     = start_date
    next_params[:end_time]       = start_date + next_date_dalta

    next_reservation = Resevation.new(next_params)
  end

  def calculate_next_date(repeat_increment_index)
    increment_date = calculate_date_increment(repeat_increment_index)
    calculate_next_start_date_day(increment_date)
  end

  # always start wtih the the original date because (Jan 30 + 1.month = Feb 28)
  def calculate_date_increment(repeat_increment_index)
    case repeat_unit
    when "year"
      start_date + (repeat_increment_index * repeat_every).year
    when "month"
      start_date + (repeat_increment_index * repeat_every).month
    when "day"
      start_date + (repeat_increment_index * repeat_every).day
    end
  end

  def calculate_next_start_date_day(increment_date)
    return increment_date if repeat_ordinal.eql?("this")

    reference_date = increment_date.at_beginning_of_month

    case repeat_ordinal
    when "first"
      return (reference_date + 0.days)  if repeat_ordinal.eql?("day")

      reference_date + days_offset(reference_date).days # first monday in month

    when "second"
      return (reference_date + 1.day)   if epeat_ordinal.eql?("day")

      reference_date + (days_offset(reference_date) + 7).days

    when "third"
      return (reference_date + 2.days)  if repeat_ordinal.eql?("day")

      reference_date + (days_offset(reference_date) + 14).days

    when "forth"
      return (reference_date + 3.days)  if repeat_ordinal.eql?("day")

      reference_date + (days_offset(reference_date) + 21).days

    # when "fifth"
    # when "last"
    end
  end

  def weekdays_offset(reference_date)
    case repeat_choice
    when "mon"
      return 0  if reference_date.cwday == 1  # monday    + 0.days = mon
      return 6  if reference_date.cwday == 2  # tuesday   + 6.days = mon
      return 5  if reference_date.cwday == 3  # wednesday + 5.days = mon
      return 4  if reference_date.cwday == 4  # thrusday  + 4.days = mon
      return 3  if reference_date.cwday == 5  # friday    + 3.days = mon
      return 2  if reference_date.cwday == 6  # saturday  + 2.days = mon
      return 1  if reference_date.cwday == 7  # sunday    + 1.days = mon

    when "tue"
      return 1  if reference_date.cwday == 1  # Monday    + 1.days = tues
      return 0  if reference_date.cwday == 2  # tuesday   + 0.days = tues
      return 6  if reference_date.cwday == 3  # wednesday + 6.days = tues
      return 5  if reference_date.cwday == 4  # thrusday  + 5.days = tues
      return 4  if reference_date.cwday == 5  # friday    + 4.days = tues
      return 3  if reference_date.cwday == 6  # saturday  + 3.days = tues
      return 2  if reference_date.cwday == 7  # sunday    + 2.days = tues

    when "wed"
      return 2  if reference_date.cwday == 1  # monday    + 2.days = weds
      return 1  if reference_date.cwday == 2  # tuesday   + 1.day  = weds
      return 0  if reference_date.cwday == 3  # wednesday + 0.days = weds
      return 6  if reference_date.cwday == 4  # thrusday  + 6.days = weds
      return 5  if reference_date.cwday == 5  # friday    + 5.days = weds
      return 4  if reference_date.cwday == 6  # saturday  + 4.days = weds
      return 3  if reference_date.cwday == 7  # sunday    + 3.days = weds

    when "thu"
      return 3  if reference_date.cwday == 1  # monday    + 3.days = thur
      return 2  if reference_date.cwday == 2  # tuesday   + 2.days = thur
      return 1  if reference_date.cwday == 3  # wednesday + 1.days = thur
      return 0  if reference_date.cwday == 4  # thrusday  + 0.days = thur
      return 6  if reference_date.cwday == 5  # friday    + 6.days = thur
      return 5  if reference_date.cwday == 6  # saturday  + 5.days = thur
      return 4  if reference_date.cwday == 7  # sunday    + 4.days = thur

    when "fri"
      return 4  if reference_date.cwday == 1  # monday    + 4.days = fri
      return 3  if reference_date.cwday == 2  # tuesday   + 3.days = fri
      return 2  if reference_date.cwday == 3  # wednesday + 2.days = fri
      return 1  if reference_date.cwday == 4  # thrusday  + 1.days = fri
      return 0  if reference_date.cwday == 5  # friday    + 0.days = fri
      return 6  if reference_date.cwday == 6  # saturday  + 6.days = fri
      return 5  if reference_date.cwday == 7  # sunday    + 5.days = fri

    when "sat"
      return 5  if reference_date.cwday == 1  # monday    + 5.days = sat
      return 4  if reference_date.cwday == 2  # tuesday   + 4.days = sat
      return 3  if reference_date.cwday == 3  # wednesday + 3.days = sat
      return 2  if reference_date.cwday == 4  # thrusday  + 2.days = sat
      return 1  if reference_date.cwday == 5  # friday    + 1.days = sat
      return 0  if reference_date.cwday == 6  # saturday  + 0.days = sat
      return 6  if reference_date.cwday == 7  # sunday    + 6.days = sat

    when "sun"
      return 6  if reference_date.cwday == 1  # monday    + 6.days = sun
      return 5  if reference_date.cwday == 2  # tuesday   + 5.days = sun
      return 4  if reference_date.cwday == 3  # wednesday + 4.days = sun
      return 3  if reference_date.cwday == 4  # thrusday  + 3.days = sun
      return 2  if reference_date.cwday == 5  # friday    + 2.days = sun
      return 1  if reference_date.cwday == 6  # saturday  + 1.days = sun
      return 0  if reference_date.cwday == 7  # sunday    + 0.days = sun

    else
      raise Managers::RepeatBookingsCreateError("shouldn't get here - bad choice") # shouldn't happen - raise error?
    end
  end

end
