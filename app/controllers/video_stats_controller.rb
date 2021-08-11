# frozen_string_literal: true

class VideoStatsController < ApplicationController
  before_action :authenticate_user!

  def show
    video = Video.find_by!(public_id: params[:video_id], user: current_user)
    render json: { stream_time_data: video.stream_time_data(params[:frequency], params[:interval]),
                   times_watched_data: video.times_watched_data(params[:frequency], params[:interval]) }
  end
end
