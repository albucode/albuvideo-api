# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: ReturnVideoStats.perform(current_user)
    # total_stream_time = VideoStreamEvent.where(user: current_user).sum(:duration).round
    #
    # stream_time_last_24h = VideoStreamEvent.where(user: current_user,
    #                                               created_at: 24.hours.ago..Time.zone.now).sum(:duration).round
    #
    # videos = Video.where(user: current_user, status: 'ready')
    # duration = videos.sum { |video| video.source_file.blob.metadata[:duration].to_f }
    # total_time_stored = duration.round
    #
    # render json: { stats: { time_streamed: total_stream_time, time_stored: total_time_stored,
    #                         time_streamed_last_24h: stream_time_last_24h } }
  end
end
