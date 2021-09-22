# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:service) }

    it { is_expected.to belong_to(:invoice) }
  end
end
