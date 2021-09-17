# frozen_string_literal: true

class WebhookSubscription < ApplicationRecord
  include PublicId

  belongs_to :user

  TOPICVALUES = %w[video/ready video/failed]

  validates :topic, :url, presence: true
  validates :url, url: { schemes: ['https'] }
  validates :topic, inclusion: { in: TOPICVALUES }
  validates :url, uniqueness: { scope: %w[topic user_id], case_sensitive: false }

  def topic_values
    TOPICVALUES
  end
end
