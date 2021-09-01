# frozen_string_literal: true

class WebhookSubscription < ApplicationRecord
  include PublicId

  belongs_to :user

  validates :topic, :url, presence: true
  validates :url, url: { schemes: ['https'] }
  validates :topic, inclusion: { in: %w[video/ready video/failed] }
  validates :url, uniqueness: { scope: %w[topic user_id], case_sensitive: false }
end
