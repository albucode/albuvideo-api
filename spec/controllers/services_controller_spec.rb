# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServicesController, type: :controller do
  subject(:service) { FactoryBot.create(:service) }

  let(:user) { FactoryBot.create(:user, is_admin: true) }
  let(:user2) { FactoryBot.create(:user) }

  before do
    sign_in(user)
  end

  describe 'service creation' do
    let(:valid_request) do
      post :create, params: { service: { name: 'ServiceName', category: 0, description: 'Service Description',
                                         price: '9.99' } }, as: :json
    end

    context 'with valid params' do
      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new service' do
        expect do
          valid_request
        end.to change(Service, :count).by(1)
      end
    end

    context 'with a user who is not admin' do
      before do
        sign_in(user2)
      end

      it 'raises ActiveRecord::RecordNotFoundexception' do
        expect { valid_request }.to raise_exception('Only an admin has access to services')
      end
    end

    context 'with invalid params' do
      let(:invalid_request) do
        post :create, params: { service: { name: '', category: '', description: '',
                                           price: '-1' } }, as: :json
      end

      it 'returns a 422' do
        invalid_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ["Name can't be blank", "Category can't be blank",
                                             "Description can't be blank", 'Price must be greater than 0'] })
      end
    end

    context 'with a repeated name' do
      let(:invalid_request) do
        post :create, params: { service: { name: service.name, category: 0, description: service.description,
                                           price: service.price } }, as: :json
      end

      it 'matches an error message' do
        response = invalid_request
        body = JSON.parse(response.body)
        expect(body).to match({ 'errors' => ['Name has already been taken'] })
      end
    end
  end
end