# frozen_string_literal: true

class StatsController < ApplicationController
  before_action :authenticate_user!

  def total_watch_time
    total_watch_time = VideoWatchEvent.where(user: current_user).sum(:duration).round

    render json: { "stats": { "time_watched": total_watch_time } }
  end
end
