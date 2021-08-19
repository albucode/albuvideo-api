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
  has_many :video_stream_events, dependent: :nullify
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

  def times_watched
    VideoStreamEvent.where(video: id).select(:session_id).distinct.count
  end

  def stream_time_data(frequency, interval)
    frequency = ActiveRecord::Base.connection.quote(frequency)
    interval = ActiveRecord::Base.connection.quote(interval)
    query = <<~SQL.squish
      SELECT sum(duration), time_bucket_gapfill( #{frequency}, video_stream_events.created_at) AS period
      FROM video_stream_events
      LEFT JOIN videos v on video_stream_events.video_id = v.id
      WHERE(public_id = '#{public_id}' AND video_stream_events.created_at BETWEEN NOW() - interval #{interval} AND NOW())
      GROUP BY period;
    SQL
    ActiveRecord::Base.connection.execute(query).to_a
  end

  def times_watched_data(frequency, interval)
    frequency = ActiveRecord::Base.connection.quote(frequency)
    interval = ActiveRecord::Base.connection.quote(interval)
    query = <<~SQL.squish
      SELECT count(DISTINCT session_id), time_bucket_gapfill( #{frequency}, video_stream_events.created_at) AS period
      FROM video_stream_events
      LEFT JOIN videos v on video_stream_events.video_id = v.id
      WHERE(public_id = '#{public_id}' AND video_stream_events.created_at BETWEEN NOW() - interval #{interval} AND NOW())
      GROUP BY period;
    SQL
    ActiveRecord::Base.connection.execute(query).to_a
  end
end
