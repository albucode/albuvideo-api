# frozen_string_literal: true

FactoryBot.define do
  factory :geolocation do
    ip_from { 136_104_192 }
    ip_to { 136_104_447 }
    country_code { 'CA' }
    country { 'Canada' }
    region { 'British Columbia' }
    city { 'Vancouver' }
  end
end
