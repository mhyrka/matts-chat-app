class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :CreatedBy, :numeric, index: true
  end
end
