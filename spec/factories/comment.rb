# frozen_string_literal: true

# create comments
FactoryBot.define do
  factory :comment do
    content { 'Lorem ipsum dolor sic amet' }

    user { FactoryBot.create(:user) }

    post { FactoryBot.create(:post) }
  end
end
