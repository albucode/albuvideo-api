# frozen_string_literal: true

class VideoStatsController < ApplicationController
  before_action :authenticate_user!

  def show
    video = Video.find_by(public_id: params[:video_id], user: current_user)
    query = video.hourly_stream_time_last_24h
    render json: ActiveRecord::Base.connection.execute(query).to_a
  end
end
