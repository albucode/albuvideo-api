# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrentUserController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  context 'when the user is signed in' do
    it 'returns the current user' do
      sign_in(user)
      get :show, as: :json

      body = JSON.parse(response.body)
      expect(body['user']).to include({ 'email' => user.email })
    end

    it 'returns :ok' do
      sign_in(user)
      get :show, as: :json

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the user is not signed in' do
    it 'returns error message' do
      get :show, as: :json

      body = JSON.parse(response.body)
      expect(body).to include('error')
    end

    it 'returns :unauthorized' do
      get :show, as: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
