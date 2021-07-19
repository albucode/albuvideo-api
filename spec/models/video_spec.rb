# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  subject(:video) { FactoryBot.build(:video) }

  it ' has a valid factory' do
    expect(video.validate!).to eq(true)
  end

  it { is_expected.to validate_presence_of(:source) }

  it { is_expected.to validate_url_of(:source) }

  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_presence_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:public_id) }

  it { is_expected.to validate_length_of(:public_id).is_equal_to(10) }

  it 'does not change an existing public_id' do
    video.save!
    loaded_video = described_class.find(video.id)

    expect(video.public_id).to eq(loaded_video.public_id)
  end

  describe '#process!' do
    let(:video) { FactoryBot.create(:video, status: :processing) }

    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it 'enqueues a SendVideoStatusWebhookJob job when webhook_subscription has topic video/ready' do
      FactoryBot.create(:webhook_subscription, user_id: video.user_id)

      video.process!

      expect(SendVideoStatusWebhookJob).to have_been_enqueued.exactly(:once)
    end

    it 'does not enqueue a SendVideoStatusWebhookJob job when webhook_subscription has topic video/fail' do
      FactoryBot.create(:webhook_subscription, user_id: video.user_id, topic: 'video/failed')

      video.process!

      expect(SendVideoStatusWebhookJob).to have_been_enqueued.exactly(0)
    end
  end
end
