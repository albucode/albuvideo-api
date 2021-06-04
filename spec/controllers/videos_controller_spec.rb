require 'rails_helper'

RSpec.describe Api::VideosController, type: :controller do
  describe 'video creation' do
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
end
