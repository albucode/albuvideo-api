# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    quantity { Faker::Number.decimal(l_digits: 2) }
    user
    service
  end
end
