# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInvoiceJob, type: :job do
  let(:service) { FactoryBot.create(:service) }
  let(:user) { FactoryBot.create(:user) }

  before do
    user
    service
  end

  it 'creates a invoice' do
    expect do
      described_class.new.perform_now
    end.to change(Invoice, :count).by(1)
  end

  it 'creates a invoice_item' do
    expect do
      described_class.new.perform_now
    end.to change(InvoiceItem, :count).by(1)
  end
end
