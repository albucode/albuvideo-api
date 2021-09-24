# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    beginning_of_last_month = Time.zone.now.last_month.beginning_of_month
    end_of_last_month = Time.zone.now.last_month.end_of_month
    starting_date = Faker::Time.between(from: beginning_of_last_month, to: end_of_last_month)
    ending_date = Faker::Time.between(from: starting_date.to_datetime, to: end_of_last_month)

    amount { Faker::Number.decimal(l_digits: 2) }
    user
    start_date { starting_date }
    end_date { ending_date }
    status { :pending }
  end
end
