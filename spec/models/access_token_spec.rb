require 'rails_helper'

RSpec.describe AccessToken, type: :model do

  subject(:access_token) { FactoryBot.build(:access_token) }

  it ' has a valid factory' do
    expect(access_token.validate!).to eq(true)
  end

  it { is_expected.to validate_presence_of(:access_token) }

  it { is_expected.to validate_presence_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:access_token) }

  it { is_expected.to validate_length_of(:public_id).is_equal_to(10) }

  it { is_expected.to validate_length_of(:access_token).is_equal_to(32) }

  it 'does not change an existing public_id' do
    access_token.save!
    loaded_access_token = described_class.find(access_token.id)

    expect(access_token.public_id).to eq(loaded_access_token.public_id)
  end

  it 'does not change an existing access_token' do
    access_token.save!
    loaded_access_token = described_class.find(access_token.id)

    expect(access_token.access_token).to eq(loaded_access_token.access_token)
  end
end
