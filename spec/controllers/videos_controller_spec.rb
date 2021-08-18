# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  let(:video) { FactoryBot.create(:video, user_id: user.id) }

  let(:video_stream_event) do
    FactoryBot.create(:video_stream_event, video_id: video.id, user_id: user.id, created_at: 10.minutes.ago)
  end

  describe 'video creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        source = 'https://albuvideo.sfo3.digitaloceanspaces.com/dev/minimal-video-with-audio.mp4'
        post :create, params: { video: { title: 'VideoTitle', published: false, source: source } },
                      as: :json
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new video ' do
        expect do
          valid_request
        end.to change(Video, :count).by(1)
      end

      it "video user_id matches current_user's id" do
        valid_request
        expect(Video.last.user_id).to match(user.id)
      end

      it 'enqueues a AttachSourceFileJob' do
        ActiveJob::Base.queue_adapter = :test

        valid_request

        expect(AttachSourceFileJob).to have_been_enqueued.exactly(:once)
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { video: { published: '', source: '' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Source can\'t be blank', 'Source is not a valid URL',
                                             'Published is not included in the list'] })
      end
    end
  end

  describe 'video show' do
    context 'with valid user' do
      before do
        sign_in(user)
      end

      let(:valid_request) do
        get :show, params: { id: video.public_id }, as: :json
      end

      it 'returns a hash with the right value for playlist_link' do
        response = valid_request
        body = JSON.parse(response.body)
        expect(body['video']['playlist_url']).to eq("http://localhost:8000/videos/#{video.public_id}.m3u8")
      end
    end
  end

  describe 'video deletion' do
    context 'when video belongs to another user' do
      subject(:video) { FactoryBot.create(:video, user_id: user2.id) }

      let(:user2) { FactoryBot.create(:user) }
      let(:invalid_request) do
        delete :destroy, params: { id: video.public_id }
      end

      before do
        sign_in(user)
      end

      it 'raises ActiveRedor::Record Not Found exception' do
        expect { invalid_request }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when video belongs to user' do
      let(:valid_request) do
        delete :destroy, params: { id: video.public_id }
      end

      before do
        sign_in(user)
      end

      it 'does not delete associated video_stream_events and nullifies its video_id' do
        video_stream_event
        valid_request
        expect(video_stream_event.reload.video_id).to be_nil
      end
    end
  end
end
