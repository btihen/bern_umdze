# frozen_string_literal: true

class AddOnsiteLimitToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :onsite_limit, :integer, null: false, default: 6
  end
end
