# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TranscodeSourceFile do
  let(:video) { FactoryBot.create(:video) }

  before do
    file = File.open(Rails.root.join('spec/support/minimal-video-with-audio.mp4'))
    stub_request(:get, 'https://albuvideo.sfo3.digitaloceanspaces.com/dev/minimal-video-with-audio.mp4')
      .to_return(status: 200, body: file, headers: {})
  end

  it 'attaches a transcoded_file to a variant' do
    AttachSourceFile.perform(video)
    described_class.perform(video, 1920, 1080)

    expect(video.variants.last.transcoded_file).to be_present
  end

  it 'enqueues a SplitVariantIntoSegmentsJob' do
    ActiveJob::Base.queue_adapter = :test

    AttachSourceFile.perform(video)
    described_class.perform(video, 1920, 1080)

    expect(SplitVariantIntoSegmentsJob).to have_been_enqueued.exactly(:once)
  end
end
