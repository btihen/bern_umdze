require 'rails_helper'

RSpec.describe Managers::RepeatBookingsCreateCommand do
  let(:command)         { Managers::RepeatBookingsCreateCommand.new(repeat_booking) }

  context "repeat every 2 months on the first sat from 08:30 until sun 18:30" do
    let(:repeat_booking)  { FactoryBot.create :repeat_booking }
    it "creates repeating reservations on appropriate days with the correct times" do
      # correct creations are first sat every two months from 09:30 Sat until 18:30 Sun

      expect(command.run).to be
      reservations = Reservation.where(repeat_booking_id: repeat_booking.id).order(start_date: :asc)

      expect(reservations.all?{ |r| r.repeat_booking_id == repeat_booking.id }).to be true
      expect(reservations.all?{ |r| r.start_time.strftime("%H:%M") == "09:30" }).to be true
      expect(reservations.all?{ |r| r.end_time.strftime("%H:%M") == "18:30" }).to be true

      # first   - jan 2-3, 2021
      # second  - mar 6-7, 2021
      # third   - may 1-2, 2021
      # fourth  - jul 3-4, 2021
      # fifth   - sep 4-5, 2021
      # sixth   - nov 6-7, 2021
      # seventh - jan 1-2, 2022
      expect(reservations.count).to eq 7

      # first   - jan 2-3, 2021
      expect(reservations[0].start_date.strftime("%Y-%m-%d")).to eq "2021-01-02"
      expect(reservations[0].end_date.strftime("%Y-%m-%d")).to eq "2021-01-03"

      # second  - mar 6-7, 2021
      expect(reservations[1].start_date.strftime("%Y-%m-%d")).to eq "2021-03-06"
      expect(reservations[1].end_date.strftime("%Y-%m-%d")).to eq "2021-03-07"

      # third   - may 1-2, 2021
      expect(reservations[2].start_date.strftime("%Y-%m-%d")).to eq "2021-05-01"
      expect(reservations[2].end_date.strftime("%Y-%m-%d")).to eq "2021-05-02"

      # fourth  - jul 3-4, 2021
      expect(reservations[3].start_date.strftime("%Y-%m-%d")).to eq "2021-07-03"
      expect(reservations[3].end_date.strftime("%Y-%m-%d")).to eq "2021-07-04"

      # fifth   - sep 4-5, 2021
      expect(reservations[4].start_date.strftime("%Y-%m-%d")).to eq "2021-09-04"
      expect(reservations[4].end_date.strftime("%Y-%m-%d")).to eq "2021-09-05"

      # sixth   - nov 6-7, 2021
      expect(reservations[5].start_date.strftime("%Y-%m-%d")).to eq "2021-11-06"
      expect(reservations[5].end_date.strftime("%Y-%m-%d")).to eq "2021-11-07"

      # seventh - jan 1-2, 2022
      expect(reservations[6].start_date.strftime("%Y-%m-%d")).to eq "2022-01-01"
      expect(reservations[6].end_date.strftime("%Y-%m-%d")).to eq "2022-01-02"
    end
  end

end
