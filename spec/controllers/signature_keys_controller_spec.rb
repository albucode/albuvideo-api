# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignatureKeysController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  describe 'signature keys creation' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_request) do
        post :create, params: { signature_key: { name: 'MySignatureKey' } }, as: :json
      end

      it 'returns a 201' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new signature_key' do
        expect do
          valid_request
        end.to change(SignatureKey, :count).by(1)
      end

      it "signature_key user_id matches current_user's id" do
        valid_request
        expect(SignatureKey.last.user_id).to match(user.id)
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { signature_key: { name: '' } }, as: :json
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

  describe 'signature_key deletion' do
    context 'when signature_key belongs to another user' do
      subject(:signature_key) { FactoryBot.create(:signature_key, user_id: user2.id) }

      let(:user2) { FactoryBot.create(:user) }
      let(:invalid_request) do
        delete :destroy, params: { id: signature_key.public_id }
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

  describe 'signature_key update' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      subject(:signature_key) { FactoryBot.create(:signature_key, user_id: user.id) }

      let(:valid_request) do
        put :update, params: { id: signature_key.public_id, signature_key: { name: 'MySignatureKeyUpdate' } }
      end

      let(:invalid_request) do
        put :update, params: { id: signature_key.public_id, signature_key: { signature_key: 'NewSignatureKey' } }
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      it 'changes the signature_key name' do
        valid_request
        expect(signature_key.reload.name).to eq('MySignatureKeyUpdate')
      end

      it 'does not change an existing signature_key' do
        invalid_request

        expect(signature_key.signature_key).to eq(signature_key.reload.signature_key)
      end
    end

    context 'with invalid params' do
      subject(:signature_key) { FactoryBot.create(:signature_key, user_id: user.id) }

      let(:invalid_request) do
        put :update, params: { id: signature_key.public_id, signature_key: { name: '' } }
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
