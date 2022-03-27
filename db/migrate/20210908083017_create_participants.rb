# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :fullname
      t.string :email,        null: false
      t.string :ip_addr,      null: false
      t.string :login_token,  null: false
      t.datetime :token_valid_until, null: false

      t.timestamps
    end
    add_index :participants, :email, unique: true
    add_index :participants, :login_token, unique: true
  end
end
