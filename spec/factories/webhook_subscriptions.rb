# frozen_string_literal: true

FactoryBot.define do
  factory :webhook_subscription do
    topic { 'video/ready' }
    url { Faker::Internet.url(scheme: 'https') }
    user
  end
end
