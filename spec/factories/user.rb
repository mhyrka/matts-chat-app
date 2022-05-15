# frozen_string_literal: true

FactoryBot.define do
  sequence :unique_email do |n|
    "test_user#{n}@somedomain.com"
  end

  factory :user do
    username { 'test_user' }

    email { generate(:unique_email) }

    password { 'HelloWorld99' }

    password_confirmation { 'HelloWorld99' }
  end
end
