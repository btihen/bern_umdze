class CreateRepeatBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :repeat_bookings do |t|

      # infos needed to create many different repeat bookings
      t.integer    :repeat_every,      null: false # every 1 month (every 2 months), etc.
      t.string     :repeat_unit,       null: false # year, month, week, day
      t.string     :repeat_ordinal,    null: false # first, second, third, fourth, fifth, last, this (date)
      t.string     :repeat_choice,     null: false # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
      t.date       :repeat_until_date, null: false # repeat until one year from today (or date chosen)

      # Template info for repeat reservations
      t.string     :host_name
      t.text       :alert_notice
      t.date       :start_date,       null: false
      t.date       :end_date,         null: false
      t.time       :start_time,       null: false
      t.time       :end_time,         null: false
      t.datetime   :start_date_time,  null: false
      t.datetime   :end_date_time,    null: false
      t.boolean    :is_cancelled,     null: false, default: false

      t.belongs_to :event,            null: false, foreign_key: true
      t.belongs_to :space,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
