class AddRepeatBookingToReservations < ActiveRecord::Migration[6.0]
  def change
    # null true (allows optionally belongs_to reservation)
    add_reference :reservations, :repeat_booking, null: true, foreign_key: true
  end
end
