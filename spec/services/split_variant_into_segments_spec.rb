# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SplitVariantIntoSegments do
  subject(:video) { FactoryBot.create(:video) }

  it 'attaches a segment_file to a segment' do
    AttachSourceFile.perform(video)
    TranscodeSourceFile.perform(video, 1920, 1080)

    described_class.perform(video.variants.last)

    expect(video.variants.last.segments.last.segment_file).to be_present
  end
end
