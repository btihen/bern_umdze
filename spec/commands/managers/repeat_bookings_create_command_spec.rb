require 'rails_helper'

RSpec.describe Managers::RepeatBookingsCreateCommand do
  let(:command)           { described_class.new(repeat_booking) }

  context "'every 1-year-on this-date (from 22:00 -> 00:30 nexy day)'" do
    let(:event_start_date){ Date.new(2021, 1, 1) }
    let(:event_end_date)  { Date.new(2021, 1, 2) }
    let(:repeat_booking)  { FactoryBot.create :repeat_booking,
                                              start_date:         event_start_date,
                                              end_date:           event_end_date,
                                              start_time:         Time.parse("22:00", event_start_date),
                                              end_time:           Time.parse("00:30", event_end_date),
                                              host_name:          "Toni",
                                              repeat_every:       1,
                                              repeat_unit:        "year",
                                              repeat_ordinal:     "this",
                                              repeat_choice:      "date",
                                              repeat_until_date:  event_start_date + 2.years }

    it "expected repeat reservations created" do
      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "22:00" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "00:30" }).to be true
      expect(reservations.all?{ |r| r.start_date == (r.end_date - 1.day) }).to be true

      expect(reservations.count).to eq 3

      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to  eq "2021-01-01"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to    eq "2022-01-02"
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to  eq "2023-01-01"
    end
  end

  context "'every 2-month-on first-saturday (through sun)'" do
    let(:event_start_date){ Date.new(2021, 1, 2) }
    let(:event_end_date)  { Date.new(2021, 1, 3) }
    let(:repeat_booking)  { FactoryBot.create :repeat_booking,
                                              start_date:         event_start_date,
                                              end_date:           event_end_date,
                                              start_time:         Time.parse("09:30", event_start_date),
                                              end_time:           Time.parse("18:30", event_end_date),
                                              host_name:          "Marianne",
                                              repeat_every:       2,
                                              repeat_unit:        "month",
                                              repeat_ordinal:     "first",
                                              repeat_choice:      "sat",
                                              repeat_until_date:  event_start_date + 1.year }

    it "expected repeat reservations created" do
      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "09:30" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "18:30" }).to be true
      expect(reservations.all?{ |r| r.start_date == (r.end_date - 1.day) }).to be true

      # makes 7 reservations (first isn't there & then one in the new year)
      expect(reservations.count).to eq 7
      # first   - jan 2-3, 2021
      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to eq "2021-01-02"
      expect(reservations[0].end_date.strftime("%Y-%m-%d")).to   eq "2021-01-03"
      # second  - mar 6-7, 2021
      expect(reservations[1].start_date.strftime("%Y-%m-%d")).to eq "2021-03-06"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to   eq "2021-03-07"
      # third   - may 1-2, 2021
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to eq "2021-05-01"
      expect(reservations[2].end_date.strftime("%Y-%m-%d")).to   eq "2021-05-02"
      # fourth  - jul 3-4, 2021
      expect(reservations[3].start_date.strftime("%Y-%m-%d")).to eq "2021-07-03"
      expect(reservations[3].end_date.strftime("%Y-%m-%d")).to   eq "2021-07-04"
      # fifth   - sep 4-5, 2021
      expect(reservations[4].start_date.strftime("%Y-%m-%d")).to eq "2021-09-04"
      expect(reservations[4].end_date.strftime("%Y-%m-%d")).to   eq "2021-09-05"
      # sixth   - nov 6-7, 2021
      expect(reservations[5].start_date.strftime("%Y-%m-%d")).to eq "2021-11-06"
      expect(reservations[5].end_date.strftime("%Y-%m-%d")).to   eq "2021-11-07"
      # seventh - jan 1-2, 2022
      expect(reservations[6].start_date.strftime("%Y-%m-%d")).to eq "2022-01-01"
      expect(reservations[6].end_date.strftime("%Y-%m-%d")).to   eq "2022-01-02"
    end
  end

  context "'every 1-month-on second-Wednesday' from 17:30 until 19:30" do
    let(:event_start_date){ Date.new(2021, 1, 2) }
    let(:event_end_date)  { Date.new(2021, 1, 2) }
    let(:repeat_booking)  { FactoryBot.create :repeat_booking,
                                              start_date:         event_start_date,
                                              end_date:           event_end_date,
                                              start_time:         Time.parse("18:00", event_start_date),
                                              end_time:           Time.parse("20:00", event_end_date),
                                              host_name:          "Toni",
                                              repeat_every:       1,
                                              repeat_unit:        "month",
                                              repeat_ordinal:     "second",
                                              repeat_choice:      "wed",
                                              repeat_until_date:  event_start_date + 1.year - 2.days }

    it "expected repeat reservations created" do
      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "18:00" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "20:00" }).to be true
      expect(reservations.all?{ |r| r.start_date == r.end_date }).to be true

      expect(reservations.count).to eq 12

      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to  eq "2021-01-13"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to    eq "2021-02-10"
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to  eq "2021-03-10"
      expect(reservations[3].end_date.strftime("%Y-%m-%d")).to    eq "2021-04-14"
      expect(reservations[4].start_date.strftime("%Y-%m-%d")).to  eq "2021-05-12"
      expect(reservations[5].end_date.strftime("%Y-%m-%d")).to    eq "2021-06-09"
      expect(reservations[6].start_date.strftime("%Y-%m-%d")).to  eq "2021-07-14"
      expect(reservations[7].end_date.strftime("%Y-%m-%d")).to    eq "2021-08-11"
      expect(reservations[8].start_date.strftime("%Y-%m-%d")).to  eq "2021-09-08"
      expect(reservations[9].end_date.strftime("%Y-%m-%d")).to    eq "2021-10-13"
      expect(reservations[10].start_date.strftime("%Y-%m-%d")).to eq "2021-11-10"
      expect(reservations[11].end_date.strftime("%Y-%m-%d")).to   eq "2021-12-08"
    end
  end

  context "'every 3-week-on mondays (no ordinals)' from 11:30 until 13:30" do
    let(:event_start_date){ Date.new(2021, 2, 2) }
    let(:event_end_date)  { Date.new(2021, 2, 2) }
    let(:repeat_booking)  { FactoryBot.create :repeat_booking,
                                              start_date:         event_start_date,
                                              end_date:           event_end_date,
                                              start_time:         Time.parse("11:30", event_start_date),
                                              end_time:           Time.parse("13:30", event_end_date),
                                              host_name:          "Toni",
                                              repeat_every:       3,
                                              repeat_unit:        "week",
                                              repeat_ordinal:     "",
                                              repeat_choice:      "mon",
                                              repeat_until_date:  event_start_date + 2.months }

    it "expected repeat reservations created" do
      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "11:30" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "13:30" }).to be true
      expect(reservations.all?{ |r| r.start_date == r.end_date }).to be true

      expect(reservations.count).to eq 3

      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to  eq "2021-02-08"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to    eq "2021-03-01"
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to  eq "2021-03-22"
    end
  end

  context "repeat every 4 days on the first day of the year from 12:00 until 13:30" do
    let(:event_start_date){ Date.new(2021, 2, 2) }
    let(:event_end_date)  { Date.new(2021, 2, 2) }
    let(:repeat_booking)  { FactoryBot.create :repeat_booking,
                                              start_date:         event_start_date,
                                              end_date:           event_end_date,
                                              start_time:         Time.parse("12:00", event_start_date),
                                              end_time:           Time.parse("13:30", event_end_date),
                                              host_name:          "Toni",
                                              repeat_every:       4,
                                              repeat_unit:        "day",
                                              repeat_ordinal:     "",
                                              repeat_choice:      "",
                                              repeat_until_date:  event_start_date + 2.weeks }

    it "creates repeating reservations on appropriate days with the correct times" do
      # correct creations are first sat every two months from 09:30 Sat until 18:30 Sun

      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "12:00" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "13:30" }).to be true
      expect(reservations.all?{ |r| r.start_date == r.end_date }).to be true

      expect(reservations.count).to eq 4

      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to  eq "2021-02-02"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to    eq "2021-02-06"
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to  eq "2021-02-10"
      expect(reservations[3].end_date.strftime("%Y-%m-%d")).to    eq "2021-02-14"
    end
  end

end
