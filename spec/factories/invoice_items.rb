# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.decimal(l_digits: 2) }
    user
    service
    invoice
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
