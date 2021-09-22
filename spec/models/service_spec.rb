# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  subject(:service) { FactoryBot.create(:service) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:category) }

  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:subscriptions) }

  it { validate_numericality_of(:price).is_greater_than(0) }

  it { validate_numericality_of(:price).is_less_than(1_000) }
end
