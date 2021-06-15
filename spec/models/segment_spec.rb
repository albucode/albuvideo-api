# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Segment, type: :model do
  subject(:segment) { FactoryBot.build(:segment) }

  it ' has a valid factory' do
    expect(segment.validate!).to eq(true)
  end

  it { is_expected.to validate_numericality_of(:position).is_greater_than(0) }

  it { is_expected.to validate_numericality_of(:duration).is_greater_than(0) }

  it { is_expected.to validate_uniqueness_of(:position).scoped_to(:variant_id) }
end
