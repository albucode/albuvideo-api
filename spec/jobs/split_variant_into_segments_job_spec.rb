# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SplitVariantIntoSegmentsJob, type: :job do
  let(:variant) { FactoryBot.create(:variant) }
  let(:video) { variant.video }

  before do
    allow(SplitVariantIntoSegments).to receive(:perform)

    described_class.new.perform(variant.id)
  end

  it 'attaches a source_file to a new video' do
    expect(SplitVariantIntoSegments).to have_received(:perform)
  end

  it 'updates video status to ready' do
    expect(video.status).to eq('ready')
  end
end
