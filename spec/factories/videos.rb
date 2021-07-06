# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { Faker::Movie.title }
    published { true }
    status { 'ready' }
    source { 'https://albuvideo.sfo3.digitaloceanspaces.com/dev/minimal-video-with-audio.mp4' }
    user
  end
end
