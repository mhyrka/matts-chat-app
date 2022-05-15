# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  belongs_to :post

  belongs_to :user

  validates_presence_of :content, :post, :user

  validates_length_of :content, minimum: 1

  paginates_per 10

  after_create do
    post.touch
  end
end
