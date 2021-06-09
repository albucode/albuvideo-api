# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe 'video creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        post :create, params: { "video": { "title": 'VideoTitle', "published": false, "source": 'testsource' } },
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
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { "video": { "published": '', "source": '' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Source can\'t be blank', 'Published is not included in the list'] })
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
  end
end
