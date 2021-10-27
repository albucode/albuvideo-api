# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookSubscriptionsController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe 'webhook_subscription creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        post :create, params: { webhook_subscription: { topic: 'video/ready', url: 'https://www.tests.com' } },
                      as: :json
      end

      it 'returns a 201' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new webhook_subscription' do
        expect do
          valid_request
        end.to change(WebhookSubscription, :count).by(1)
      end

      it "webhook_subscription user_id matches current_user's id" do
        valid_request
        expect(WebhookSubscription.last.user_id).to eq(user.id)
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { webhook_subscription: { topic: '', url: '' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Topic can\'t be blank',  'Url can\'t be blank',
                                             'Url is not a valid URL', 'Topic is not included in the list'] })
      end
    end
  end

  describe 'webhook_subscription deletion' do
    context 'when webhook_subscription belongs to another user' do
      subject(:webhook_subscription) { FactoryBot.create(:webhook_subscription, user_id: user2.id) }

      let(:user2) { FactoryBot.create(:user) }
      let(:invalid_request) do
        delete :destroy, params: { id: webhook_subscription.public_id }
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

  describe 'webhook_subscription update' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      subject(:webhook_subscription) { FactoryBot.create(:webhook_subscription, user_id: user.id) }

      let(:valid_request) do
        post :update, params: { id: webhook_subscription.public_id, webhook_subscription:
          { topic: 'video/ready', url: 'https://www.tests-update.com' } }, as: :json
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      it 'changes the url' do
        valid_request
        expect(webhook_subscription.reload.url).to eq('https://www.tests-update.com')
      end
    end

    context 'with invalid params' do
      subject(:webhook_subscription) { FactoryBot.create(:webhook_subscription, user_id: user.id) }

      let(:invalid_request) do
        put :update, params: { id: webhook_subscription.public_id, webhook_subscription: { topic: '' } },
                     as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Topic can\'t be blank', 'Topic is not included in the list'] })
      end
    end
  end
end
