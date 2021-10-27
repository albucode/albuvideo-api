# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe 'access token creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        post :create, params: { access_token: { name: 'MyAccessToken' } }, as: :json
      end

      it 'returns a 201' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new access_token' do
        expect do
          valid_request
        end.to change(AccessToken, :count).by(1)
      end

      it "access_token user_id matches current_user's id" do
        valid_request
        expect(AccessToken.last.user_id).to match(user.id)
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { access_token: { name: '' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Name can\'t be blank'] })
      end
    end
  end

  describe 'access_token deletion' do
    context 'when access_token belongs to another user' do
      subject(:access_token) { FactoryBot.create(:access_token, user_id: user2.id) }

      let(:user2) { FactoryBot.create(:user) }
      let(:invalid_request) do
        delete :destroy, params: { id: access_token.public_id }
      end

      before do
        sign_in(user)
      end

      it 'displays an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'error' => 'This record does not exist' })
      end
    end
  end

  describe 'access token update' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      subject(:access_token) { FactoryBot.create(:access_token, user_id: user.id) }

      let(:valid_request) do
        put :update, params: { id: access_token.public_id, access_token: { name: 'MyAccessTokenUpdate' } }
      end

      let(:invalid_request) do
        put :update, params: { id: access_token.public_id, access_token: { access_token: 'NewAccessToken' } }
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      it 'changes the access_token name ' do
        valid_request
        expect(access_token.reload.name).to eq('MyAccessTokenUpdate')
      end

      it 'does not change an existing access_token' do
        invalid_request

        expect(access_token.access_token).to eq(access_token.reload.access_token)
      end
    end

    context 'with invalid params' do
      subject(:access_token) { FactoryBot.create(:access_token, user_id: user.id) }

      let(:invalid_request) do
        put :update, params: { id: access_token.public_id, access_token: { name: '' } }
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Name can\'t be blank'] })
      end
    end
  end
end
