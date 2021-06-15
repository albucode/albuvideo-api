# frozen_string_literal: true

FactoryBot.define do
  factory :segment do
    variant
    position { 1 }
    duration { 1.5 }
  end
end
