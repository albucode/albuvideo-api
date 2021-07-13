# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe 'webhook creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        post :create, params: { webhook: { topic: 'video/ready', url: 'https://www.tests.com' } },
                      as: :json
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new webhook' do
        expect do
          valid_request
        end.to change(Webhook, :count).by(1)
      end

      it "webhook user_id matches current_user's id" do
        valid_request
        expect(Webhook.last.user_id).to match(user.id)
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { webhook: { topic: '', url: '' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Topic can\'t be blank',  'Url can\'t be blank',
                                             'Url is not a valid URL', 'Topic must be accepted'] })
      end
    end
  end

  describe 'webhook deletion' do
    context 'when webhook belongs to another user' do
      subject(:webhook) { FactoryBot.create(:webhook, user_id: user2.id) }

      let(:user2) { FactoryBot.create(:user) }
      let(:invalid_request) do
        delete :destroy, params: { id: webhook.public_id }
      end

      before do
        sign_in(user)
      end

      it 'raises ActiveRecord::Record Not Found exception' do
        expect { invalid_request }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'access token update' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      subject(:webhook) { FactoryBot.create(:webhook, user_id: user.id) }

      let(:valid_request) do
        post :update, params: { id: webhook.public_id, webhook: { topic: 'video/ready', url: 'https://www.tests-update.com' } },
                      as: :json
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      it 'changes the url' do
        valid_request
        expect(webhook.reload.url).to eq('https://www.tests-update.com')
      end
    end

    context 'with invalid params' do
      subject(:webhook) { FactoryBot.create(:webhook, user_id: user.id) }

      let(:invalid_request) do
        put :update, params: { id: webhook.public_id, webhook: { topic: '' } },
                     as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Topic can\'t be blank', 'Topic must be accepted'] })
      end
    end
  end
end
