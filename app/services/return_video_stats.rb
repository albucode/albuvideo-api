# frozen_string_literal: true

class ReturnVideoStats
  include AbstractController::Rendering

  def self.perform(user)
    total_stream_time = VideoStreamEvent.where(user: user).sum(:duration).round

    stream_time_last_24h = VideoStreamEvent.where(user: user,
                                                  created_at: 24.hours.ago..Time.zone.now).sum(:duration).round

    videos = Video.where(user: user, status: 'ready')
    duration = videos.sum { |video| video.source_file.blob.metadata[:duration].to_f }
    total_time_stored = duration.round

    { stats: { time_streamed: total_stream_time, time_stored: total_time_stored,
               time_streamed_last_24h: stream_time_last_24h } }
  end
end
