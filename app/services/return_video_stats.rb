# frozen_string_literal: true

class ReturnVideoStats
  class << self
    def perform(user)
      { stats: { time_streamed: total_stream_time(user), time_stored: total_time_stored(user),
                 time_streamed_last_24h: stream_time_last_24h(user) } }
    end

    private

    def total_stream_time(user)
      VideoStreamEvent.where(user: user).sum(:duration).round
    end

    def stream_time_last_24h(user)
      VideoStreamEvent.where(user: user, created_at: 24.hours.ago..Time.zone.now).sum(:duration).round
    end

    def total_time_stored(user)
      videos = Video.where(user: user, status: 'ready')
      duration = videos.sum { |video| video.source_file.blob.metadata[:duration].to_f }
      duration.round
    end
  end
end
