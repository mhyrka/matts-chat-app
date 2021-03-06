# frozen_string_literal: true

# Post model
class Post < ApplicationRecord
  belongs_to :user

  has_many :comments

  validates_presence_of :content, :title, :user

  validates_length_of :content, :title, minimum: 5

  validates_length_of :title, maximum: 120

  default_scope { where deleted: false }

  scope :homepage, (
    lambda do |page_num|
      includes(:comments)
      .includes(:user)
      .order(updated_at: :desc)
      .order(created_at: :desc)
      .page(page_num)
    end)

  #   paginates_per 10
end
