# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoWatchEvent, type: :model do
  subject(:video_watch_event) { FactoryBot.build(:video_watch_event) }

  it ' has a valid factory' do
    expect(video_watch_event.validate!).to eq(true)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:video).class_name('Video') }
    it { is_expected.to belong_to(:user).class_name('User') }
  end
end
