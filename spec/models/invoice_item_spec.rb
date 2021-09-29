# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:service) }

    it { is_expected.to belong_to(:invoice) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }

    it { validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_presence_of(:price) }

    it { validate_numericality_of(:price).is_greater_than(0) }

    it { validate_numericality_of(:price).is_less_than(1_000) }
  end
end
