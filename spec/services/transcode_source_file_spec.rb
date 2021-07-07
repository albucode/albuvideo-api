# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TranscodeSourceFile do
  let(:video) { FactoryBot.create(:video) }

  it 'attaches a transcoded_file to a variant' do
    AttachSourceFile.perform(video)
    described_class.perform(video, 1920, 1080)

    expect(video.variants.last.transcoded_file).to be_present
  end
end