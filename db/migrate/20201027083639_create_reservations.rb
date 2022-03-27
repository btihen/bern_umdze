# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string     :host_name
      t.text       :alert_notice
      # simplifies input
      t.date       :start_date,       null: false
      t.date       :end_date,         null: false
      t.time       :start_time,       null: false
      t.time       :end_time,         null: false
      # simplifies sorting (build in model)
      t.datetime   :start_date_time,  null: false
      t.datetime   :end_date_time,    null: false
      t.boolean    :is_cancelled,     null: false, default: false

      t.belongs_to :event,            null: false, foreign_key: true
      t.belongs_to :space,            null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations,  :end_date
    add_index :reservations,  :start_date
    add_index :reservations, %i[event_id space_id start_date_time end_date_time],
              unique: true, name: 'index_reservation_unique'
  end
end
