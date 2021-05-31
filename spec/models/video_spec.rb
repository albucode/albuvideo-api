require 'rails_helper'

RSpec.describe Video, type: :model do
  subject(:video) { FactoryBot.build(:video) }

  it ' has a valid factory' do
    expect(video.validate!).to eq(true)
  end
end
