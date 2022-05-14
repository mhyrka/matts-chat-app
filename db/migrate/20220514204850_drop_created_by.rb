class DropCreatedBy < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :CreatedBy
  end
end
