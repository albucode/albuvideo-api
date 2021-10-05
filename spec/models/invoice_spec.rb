# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:invoice) { FactoryBot.create(:invoice, user_id: user.id) }
  let(:invoice_item) do
    FactoryBot.create(:invoice_item, quantity: 10, price: 20, invoice_id: invoice.id, user_id: user.id)
  end
  let(:invoice_item2) do
    FactoryBot.create(:invoice_item, quantity: 10, price: 30, invoice_id: invoice.id, user_id: user.id)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:invoice_items) }
  end

  it 'calculates invoice_total' do
    invoice_item
    invoice_item2
    expect(invoice.invoice_total).to eq(500)
  end
end
