# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :authenticate_user!

  def show
    total_stream_time = VideoStreamEvent.where(user: current_user).sum(:duration).round

    render json: { stats: { time_streamed: total_stream_time } }
  end
end
