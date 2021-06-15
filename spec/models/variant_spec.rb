# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  subject(:variant) { FactoryBot.build(:variant) }

  it ' has a valid factory' do
    expect(variant.validate!).to eq(true)
  end

  it { is_expected.to validate_presence_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:public_id) }

  it { is_expected.to validate_length_of(:public_id).is_equal_to(10) }

  it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }

  it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }

  it { is_expected.to validate_numericality_of(:bitrate).is_greater_than(0) }

  it 'does not change an existing public_id' do
    variant.save!
    loaded_variant = described_class.find(variant.id)

    expect(variant.public_id).to eq(loaded_variant.public_id)
  end
end
