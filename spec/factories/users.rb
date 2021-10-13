# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email {  Faker::Internet.email }
    password { Faker::Internet.password }
    is_admin { false }
  end
end
