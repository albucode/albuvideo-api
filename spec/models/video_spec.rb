require 'rails_helper'

RSpec.describe Video, type: :model do
  subject(:video) { FactoryBot.build(:video) }

  it ' has a valid factory' do
    expect(video.validate!).to eq(true)
  end

  it { is_expected.to validate_presence_of(:published) }
  it { is_expected.to validate_presence_of(:source) }
  it { is_expected.to validate_presence_of(:status) }
end
