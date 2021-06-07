# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  subject(:video) { FactoryBot.build(:video) }

  it ' has a valid factory' do
    expect(video.validate!).to eq(true)
  end
  
  it { is_expected.to validate_presence_of(:source) }

  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_presence_of(:public_id) }

  it { is_expected.to validate_uniqueness_of(:public_id) }

  it { is_expected.to validate_length_of(:public_id).is_equal_to(10) }

  it 'does not change an existing public_id' do
    video.save!
    loaded_video = Video.find(video.id)

    expect(video.public_id).to eq(loaded_video.public_id)
  end
end
