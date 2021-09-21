# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    name { Faker::Movie.title }
    category { 0 }
    description { Faker::Lorem.paragraph }
    price { '9.99' }
  end
end
