# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Test Title' }

    content { 'lorem ipsum dolor sit amet' }

    user { FactoryBot.create(:user) }
  end
end
