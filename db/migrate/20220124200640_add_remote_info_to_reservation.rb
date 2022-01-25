class AddRemoteInfoToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :remote_info, :text
  end
end
