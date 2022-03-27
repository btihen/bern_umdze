# frozen_string_literal: true

class ChangeRemoteLinkToText < ActiveRecord::Migration[6.1]
  def change
    change_column :reservations, :remote_link, :text
  end
end
