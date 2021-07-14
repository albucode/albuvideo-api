# frozen_string_literal: true

class WebhookSubscription < ApplicationRecord
  include PublicId

  belongs_to :user

  validates :topic, :url, presence: true
  validates :url, url: true
  validates :topic, inclusion: { in: %w[video/ready video/failed] }
end
