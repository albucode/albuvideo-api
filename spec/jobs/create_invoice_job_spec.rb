# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInvoiceJob, type: :job do
  let(:sometime_last_month) { Time.zone.now.last_month }

  let(:service) { FactoryBot.create(:service) }
  let(:user) { FactoryBot.create(:user) }
  let(:video) { FactoryBot.create(:video, user_id: user.id) }

  let(:video_stream_event) do
    FactoryBot.create(:video_stream_event, user_id: user.id, video_id: video.id, created_at: sometime_last_month)
  end

  let(:video_stream_event2) do
    FactoryBot.create(:video_stream_event, user_id: user.id, video_id: video.id, created_at: sometime_last_month)
  end

  before do
    user
    service
  end

  it 'creates a invoice' do
    expect do
      described_class.new.perform
    end.to change(Invoice, :count).by(1)
  end

  it 'creates a invoice_item' do
    expect do
      described_class.new.perform
    end.to change(InvoiceItem, :count).by(1)
  end

  describe 'it saves the correct values' do
    before do
      video_stream_event
      video_stream_event2
      described_class.new.perform_now
    end

    context 'when invoice_item is created' do
      it 'calculates stream_time quantity' do
        expect(InvoiceItem.last.quantity).to eq(3)
      end

      it 'associates the right service' do
        expect(InvoiceItem.last.service_id).to eq(service.id)
      end

      it 'associates the right user' do
        expect(InvoiceItem.last.user_id).to eq(user.id)
      end

      it 'associates the right price' do
        expect(InvoiceItem.last.price).to eq(service.price)
      end

      it 'associates the right invoice' do
        expect(InvoiceItem.last.invoice_id).to eq(Invoice.last.id)
      end
    end

    context 'when invoice is created' do
      it 'calculates beginning_of_last_month' do
        expect(Invoice.last.start_date).to eq(Time.zone.now.last_month.beginning_of_month)
      end

      it 'calculates end_of_last_month' do
        expect(Invoice.last.end_date.to_i).to eq(Time.zone.now.last_month.end_of_month.to_i)
      end

      it 'associates the right user' do
        expect(Invoice.last.user_id).to eq(user.id)
      end

      it 'associates the right status' do
        expect(Invoice.last.status).to eq('pending')
      end
    end
  end
end
