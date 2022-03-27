# frozen_string_literal: true

class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string  :space_name, null: false
      t.text    :space_location
      t.boolean :publicly_visible, null: false, default: true

      t.timestamps
    end
    add_index :spaces, :space_name, unique: true
  end
end
