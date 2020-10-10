class CreateRepeatBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :repeat_bookings do |t|
      t.json :settings

      t.timestamps
    end
  end
end
