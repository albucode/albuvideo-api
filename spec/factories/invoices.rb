# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    amount { '9.99' }
    user { nil }
    start_date { '2021-09-21 16:30:26' }
    end_date { '2021-09-21 16:30:26' }
    public_id { 'MyString' }
    status { 0 }
  end
end
