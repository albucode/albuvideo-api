# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }

  let(:user2) { FactoryBot.create(:user) }
  let(:invoice) { FactoryBot.create(:invoice, user_id: user.id) }
  let(:invoice2) { FactoryBot.create(:invoice, user_id: user2.id) }

  describe 'get invoices index' do
    let(:valid_request) do
      get :index
    end

    context 'with a valid authenticated user' do
      before do
        invoice
        invoice2
        sign_in(user)
      end

      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns an array of invoices' do
        response = valid_request
        body = JSON.parse(response.body)
        expect(body['invoices'].map { |invoice| invoice['id'] }).not_to include(invoice2.id)
      end
    end

    context 'with guest user' do
      it 'returns a 200' do
        valid_request
        expect(response).to have_http_status(:found)
      end
    end
  end
end
