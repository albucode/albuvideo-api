# frozen_string_literal: true

FactoryBot.define do
  factory :signature_key do
    name { 'MyString' }
    signature_key { 'MyString' }
    public_id { 'MyString' }
    user { nil }
  end
end
