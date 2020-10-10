class AddRepeatBookingToReservations < ActiveRecord::Migration[6.0]
  def change
    # null true (optionally belongs_to)
    add_reference :reservations, :repeat_booking, null: true, foreign_key: true
  end
end
