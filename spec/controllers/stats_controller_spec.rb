# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  let(:video) { FactoryBot.create(:video) }

  let(:video_watch_event) { FactoryBot.create(:video_watch_event, video_id: video.id, user_id: user.id) }
  let(:video_watch_event2) { FactoryBot.create(:video_watch_event, video_id: video.id, user_id: user.id, duration: 2) }

  describe 'get total watch time' do
    before do
      sign_in(user)
    end

    let(:request) do
      get :show, as: :json
    end

    it 'returns a the sum of all duration for user\'s video watch time' do
      video_watch_event
      video_watch_event2
      body = JSON.parse(request.body)
      expect(body).to match({ 'stats' => { 'time_watched' => 4 } })
    end

    it 'returns 0 when user has not created any video_watch_events' do
      body = JSON.parse(request.body)
      expect(body).to match({ 'stats' => { 'time_watched' => 0 } })
    end
  end
end
