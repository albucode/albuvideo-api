# frozen_string_literal: true

class Video < ApplicationRecord
  include AASM
  include PublicId

  aasm column: 'status' do
    state :processing, initial: true
    state :ready

    event :process do
      after do
        webhook_subscription = WebhookSubscription.find_by(user_id: user_id, topic: 'video/ready')
        SendVideoStatusWebhookJob.perform_later(webhook_subscription.id, id) if webhook_subscription
      end
      transitions from: :processing, to: :ready
    end
  end

  belongs_to :user
  has_many :variants, dependent: :destroy
  has_many :video_stream_events, dependent: :destroy
  has_one_attached :source_file

  enum status: { processing: 0, ready: 1, failed: 2 }, _default: :processing

  validates :source, :status, presence: true
  validates :source, url: true

  validates :published, inclusion: { in: [true, false] }

  def total_stream_time
    VideoStreamEvent.where(video: id).sum(:duration).round
  end

  def stream_time_last_24h
    VideoStreamEvent.where(video: id, created_at: 24.hours.ago..Time.zone.now).sum(:duration).round
  end
end
