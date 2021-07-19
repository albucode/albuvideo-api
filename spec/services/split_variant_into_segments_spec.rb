# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SplitVariantIntoSegments do
  subject(:video) { FactoryBot.create(:video) }

  before do
    file = File.open(Rails.root.join('spec/support/minimal-video-with-audio.mp4'))
    stub_request(:get, 'https://albuvideo.sfo3.digitaloceanspaces.com/dev/minimal-video-with-audio.mp4')
      .to_return(status: 200, body: file, headers: {})
  end

  it 'attaches a segment_file to a segment' do
    AttachSourceFile.perform(video)
    TranscodeSourceFile.perform(video, 1920, 1080)

    described_class.perform(video.variants.last)

    expect(Segment.last.segment_file).to be_present
  end
end
