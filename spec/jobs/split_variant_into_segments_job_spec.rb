# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SplitVariantIntoSegmentsJob, type: :job do
  let(:variant) { FactoryBot.create(:variant) }

  it 'attaches a source_file to a new video' do
    allow(SplitVariantIntoSegments).to receive(:perform)

    described_class.new.perform(variant.id)

    expect(SplitVariantIntoSegments).to have_received(:perform)
  end
end
