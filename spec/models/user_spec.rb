# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:subscriptions) }

    it { is_expected.to have_many(:invoices) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
