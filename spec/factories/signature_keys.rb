# frozen_string_literal: true

FactoryBot.define do
  factory :signature_key do
    name { 'MySignatureKey' }
    user
  end
end
