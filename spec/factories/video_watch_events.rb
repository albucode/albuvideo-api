# frozen_string_literal: true

FactoryBot.define do
  factory :video_watch_event do
    video
    duration { 1.5 }
  end
end
