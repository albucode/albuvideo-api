# frozen_string_literal: true

FactoryBot.define do
  factory :webhook do
    topic { 'video/ready' }
    url { Faker::Internet.url }
    user
  end
end
