# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoStatsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:video) { FactoryBot.create(:video, user_id: user.id) }

  let(:user2) { FactoryBot.create(:user, email: 'user2@email.com') }

  describe 'video_stats show' do
    context 'with valid user' do
      before do
        sign_in(user)
      end

      let(:valid_request) do
        get :show, params: { video_id: video.public_id, interval: '24hours', frequency: '1hour' }, as: :json
      end

      it 'returns a 200' do
        expect(valid_request).to have_http_status(:ok)
      end

      it "returns an array of hashes with keys 'sum'" do
        response = valid_request
        body = JSON.parse(response.body)
        expect(body['stream_time_data'][0]).to have_key('sum')
      end

      it "returns an array of hashes with keys 'count'" do
        response = valid_request
        body = JSON.parse(response.body)
        expect(body['times_watched_data'][0]).to have_key('count')
      end
    end

    context 'with invalid user' do
      before do
        sign_in(user2)
      end

      let(:invalid_request) do
        get :show, params: { video_id: video.public_id }, as: :json
      end

      it 'displays an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'error' => 'This record does not exist' })
      end
    end
  end
end
