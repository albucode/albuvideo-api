# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:subscriptions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }

    it { validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end
end
