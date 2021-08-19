# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  subject(:video) { FactoryBot.create(:video) }

  let(:video2) { FactoryBot.create(:video) }
  let(:video_stream_event) { FactoryBot.create(:video_stream_event, video_id: video.id, created_at: 2.days.ago) }
  let(:video_stream_event2) { FactoryBot.create(:video_stream_event, video_id: video.id, created_at: 10.minutes.ago) }
  let(:video_stream_event3) { FactoryBot.create(:video_stream_event, video_id: video.id, created_at: 10.minutes.ago) }
  let(:video_stream_event4) { FactoryBot.create(:video_stream_event, video_id: video2.id, created_at: 10.minutes.ago) }

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

  describe 'get total stream time' do
    it "returns a the sum of all duration for a video's stream time" do
      video_stream_event
      video_stream_event2

      expect(video.total_stream_time).to equal(3)
    end

    it 'returns 0 when video has never been streamed' do
      expect(video.total_stream_time).to equal(0)
    end
  end

  describe 'get total stream time for last 24h' do
    it "returns a the sum of all duration for a video's stream time for last 24h'" do
      video_stream_event
      video_stream_event2

      expect(video.stream_time_last_24h).to equal(2)
    end

    it 'returns 0 when video has never been streamed' do
      expect(video.stream_time_last_24h).to equal(0)
    end
  end

  describe 'gets sums of stream_time' do
    it "returns a sum of durations for a video's stream time during a certain interval" do
      video_stream_event2
      video_stream_event3
      my_array = video.stream_time_data('1hour', '24hours')

      expect(my_array.find { |item| item['sum'] == 3.0.to_d }).not_to be_nil
    end
  end

  describe 'gets counts of times watched' do
    it 'returns a count of times a video has been watched during a certain interval' do
      video_stream_event2
      video_stream_event3
      my_array = video.times_watched_data('1hour', '24hours')

      expect(my_array.find { |item| item['count'] == 2 }).not_to be_nil
    end
  end

  describe 'gets the number of times a video has been watched' do
    it 'returns the number of unique session_ids for a video' do
      video_stream_event
      video_stream_event2
      video_stream_event4

      expect(video.times_watched).to equal(2)
    end

    it 'returns 0 when video has never been watched' do
      expect(video.times_watched).to equal(0)
    end
  end
end
