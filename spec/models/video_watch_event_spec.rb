# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoWatchEvent, type: :model do
  subject(:video_watch_event) { FactoryBot.build(:video_watch_event) }

  it ' has a valid factory' do
    expect(video_watch_event.validate!).to eq(true)
  end

  it { is_expected.to validate_numericality_of(:duration).is_greater_than(0) }

  describe 'associations' do
    it { is_expected.to belong_to(:video) }
    it { is_expected.to belong_to(:user) }
  end
end
