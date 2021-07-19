# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoStreamEvent, type: :model do
  subject(:video_stream_event) { FactoryBot.build(:video_stream_event) }

  it ' has a valid factory' do
    expect(video_stream_event.validate!).to eq(true)
  end

  it { is_expected.to validate_numericality_of(:duration).is_greater_than(0) }

  describe 'associations' do
    it { is_expected.to belong_to(:video) }
    it { is_expected.to belong_to(:user) }
  end
end
