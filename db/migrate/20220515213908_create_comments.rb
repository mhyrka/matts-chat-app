# frozen_string_literal: true

# comments migration
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, nil: false

      t.references :post, index: true

      t.references :user, index: true

      t.timestamps
    end
  end
end
