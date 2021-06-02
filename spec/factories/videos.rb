# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { Faker::Movie.title }
    published { true }
    status { 'ready' }
    source { Faker::Internet.url }
  end
end
