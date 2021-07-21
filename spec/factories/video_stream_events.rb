# frozen_string_literal: true

FactoryBot.define do
  factory :video_stream_event do
    video
    user
    duration { 1.5 }
  end
end
