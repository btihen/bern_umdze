class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :real_name, :string
    add_column :users, :user_role, :string
    add_column :users, :username,  :string, null: false

    add_index :users, :username, unique: true
  end
end
