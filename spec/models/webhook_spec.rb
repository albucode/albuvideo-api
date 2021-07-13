# frozen_string_literal: true

require 'rails_helper'
require 'validate_url/rspec_matcher'

RSpec.describe Webhook, type: :model do
  subject(:webhook) { FactoryBot.build(:webhook) }

  it ' has a valid factory' do
    expect(webhook.validate!).to eq(true)
  end

  it { is_expected.to validate_url_of(:url) }

  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_acceptance_of(:topic) }
end
