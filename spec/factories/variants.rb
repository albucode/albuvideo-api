# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    video
    height { 1 }
    width { 1 }
    bitrate { 1 }
  end
end
