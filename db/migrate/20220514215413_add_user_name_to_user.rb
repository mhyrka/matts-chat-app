# frozen_string_literal: true

# add username
class AddUserNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
  end
end
