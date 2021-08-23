# frozen_string_literal: true

FactoryBot.define do
  factory :country_permission do
    country { 1 }
    video { 1 }
  end
end
