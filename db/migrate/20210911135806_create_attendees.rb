class CreateAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees do |t|
      t.string :location
      t.references :user, foreign_key: true
      t.references :participant, foreign_key: true
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
    add_index :attendees, [:user_id, :participant_id, :reservation_id],
                          unique: true,
                          name: 'index_unique_attendee_per_reservation'
  end
end
