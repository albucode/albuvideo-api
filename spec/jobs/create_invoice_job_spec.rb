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

  it 'calculates stream_time quantity' do
    video_stream_event
    video_stream_event2
    described_class.new.perform_now

    expect(InvoiceItem.last.quantity).to eq(3)
  end
end
