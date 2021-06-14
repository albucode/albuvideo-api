# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignatureKey, type: :model do
  subject(:signature_key) { FactoryBot.build(:signature_key) }

  it ' has a valid factory' do
    expect(signature_key.validate!).to eq(true)
  end

  it { is_expected.to validate_presence_of(:signature_key) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:signature_key) }

  it { is_expected.to validate_length_of(:public_id).is_equal_to(10) }

  it { is_expected.to validate_length_of(:signature_key).is_equal_to(64) }

  it 'does not change an existing public_id' do
    signature_key.save!
    loaded_signature_key = described_class.find(signature_key.id)

    expect(signature_key.public_id).to eq(loaded_signature_key.public_id)
  end

  it 'does not change an existing signature_key' do
    signature_key.save!
    loaded_signature_key = described_class.find(signature_key.id)

    expect(signature_key.signature_key).to eq(loaded_signature_key.signature_key)
  end
end
