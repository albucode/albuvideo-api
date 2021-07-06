# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachSourceFile do
  subject(:video) { FactoryBot.build(:video) }

  it 'attaches a source_file to a video' do
    described_class.perform(video)

    expect(video.source_file).to be_present
  end
end
