# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachSourceFileJob, type: :job do
  let(:video) { FactoryBot.create(:video) }

  it 'attaches a source_file to a new video' do
    allow(AttachSourceFile).to receive(:perform)

    described_class.new.perform(video.id)

    expect(AttachSourceFile).to have_received(:perform)
  end
end
