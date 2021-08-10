# frozen_string_literal: true

class VideoStatsController < ApplicationController
  before_action :authenticate_user!

  def show
    video = Video.find_by!(public_id: params[:video_id], user: current_user)
    render json: video.stream_time_data(params[:frequency], params[:interval])
  end
end
