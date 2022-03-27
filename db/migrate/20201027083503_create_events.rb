# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.string :event_description

      t.timestamps
    end
    add_index :events, :event_name, unique: true
  end
end
