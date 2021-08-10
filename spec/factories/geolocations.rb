# frozen_string_literal: true

FactoryBot.define do
  factory :geolocation do
    ip_from { 1 }
    ip_to { 1 }
    country_code { 'MyString' }
    country { 'MyString' }
    region { 'MyString' }
    city { 'MyString' }
  end
end
