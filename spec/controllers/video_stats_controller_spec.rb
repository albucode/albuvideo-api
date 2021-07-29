# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoStatsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:video) { FactoryBot.create(:video, user_id: user.id) }

  describe 'video_stats show' do
    before do
      sign_in(user)
    end

    context 'with valid user' do
      let(:valid_request) do
        get :show, params: { video_id: video.public_id }
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      # it "video user_id matches current_user's id" do
      #   valid_request
      #   expect(Video.last.user_id).to match(user.id)
      # end
    end

    # context 'with invalid user' do
    #   let(:invalid_request) do
    #     post :create, params: { video: { published: '', source: '' } }, as: :json
    #   end
    #
    #   it 'returns a 422' do
    #     invalid_request
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    #
    #   it 'matches an error message' do
    #     response = invalid_request
    #     body = JSON.parse(response.body)
    #     expect(body).to match({ 'errors' => ['Source can\'t be blank', 'Source is not a valid URL',
    #                                          'Published is not included in the list'] })
    #   end
    # end
  end
end
