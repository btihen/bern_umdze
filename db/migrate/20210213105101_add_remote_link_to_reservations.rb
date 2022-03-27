# frozen_string_literal: true

class AddRemoteLinkToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :remote_link, :string
  end
end
