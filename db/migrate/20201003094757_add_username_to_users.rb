class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :real_name,   :string, null: false
    add_column :users, :username,    :string, null: false
    add_column :users, :access_role, :string, null: false, default: 'viewer'

    add_index :users, :username, unique: true
  end
end
