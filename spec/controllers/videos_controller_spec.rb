require 'rails_helper'

RSpec.describe Api::VideosController, type: :controller do
  describe 'video creation' do

    context 'with valid params' do

      let(:valid_request) do
        post :create, params: { "video": { "title": "VideoTitle", "published": false, "source": "testsource" } }, as: :json
      end

      it "returns a 200" do
        valid_request
        expect(response).to have_http_status(201)
      end

      it "creates a new video " do
        expect {
          valid_request
        }.to change(Video, :count).by(1)
      end
    end
  end
end

