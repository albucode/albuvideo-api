# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendVideoStatusWebhookJob, type: :job do
  let(:video) { FactoryBot.create(:video, status: :processing) }
  let(:webhook_subscription) { FactoryBot.create(:webhook_subscription, user_id: video.user_id) }

  it 'sends a POST request to webhook_subscription URL' do
    stub = stub_request(:post, webhook_subscription.url)

    described_class.new.perform(webhook_subscription.id, video.id)

    expect(stub).to have_been_requested
  end
end
