# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  let(:video) { FactoryBot.create(:video) }

  let(:video_stream_event) do
    FactoryBot.create(:video_stream_event, video_id: video.id, user_id: user.id, created_at: 10.minutes.ago)
  end

  let(:video_stream_event2) do
    FactoryBot.create(:video_stream_event, video_id: video.id, user_id: user.id, duration: 2, created_at: 2.days.ago)
  end

  let(:video_stream_event3) do
    FactoryBot.create(:video_stream_event, video_id: video.id, user_id: user.id, duration: 2,
                                           created_at: 12.minutes.ago)
  end

  let(:request) do
    get :show, as: :json
  end

  before do
    sign_in(user)
  end

  describe 'get total stream time' do
    it 'returns a the sum of all duration for user\'s video stream time' do
      video_stream_event
      video_stream_event2
      body = JSON.parse(request.body)
      expect(body['stats']['time_streamed']).to eq(4)
    end

    it 'returns 0 when user has not created any video_stream_events' do
      body = JSON.parse(request.body)
      expect(body['stats']['time_streamed']).to eq(0)
    end
  end

  describe 'get total stream time for the last 24h' do
    it 'returns a the sum of all duration for user\'s video stream time for the last 24h' do
      video_stream_event
      video_stream_event2
      video_stream_event3
      body = JSON.parse(request.body)
      expect(body['stats']['time_streamed_last_24h']).to eq(4)
    end

    it 'returns 0 when user has not created any video_stream_events on the last 24h' do
      video_stream_event2
      body = JSON.parse(request.body)
      expect(body['stats']['time_streamed_last_24h']).to eq(0)
    end
  end
end
