# frozen_string_literal: true

class WebhookSubscription < ApplicationRecord
  TOPICS = %w[video/ready video/failed].freeze

  include PublicId

  belongs_to :user

  validates :topic, :url, presence: true
  validates :url, url: { schemes: ['https'] }
  validates :topic, inclusion: { in: TOPICS }
  validates :url, uniqueness: { scope: %w[topic user_id], case_sensitive: false }
end
