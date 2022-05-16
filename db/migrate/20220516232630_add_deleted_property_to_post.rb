class AddDeletedPropertyToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :deleted, :boolean, default: false, nil: false
  end
end
