# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    name { Faker::Movie.title }
    category { :streaming }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
