class Api::VideosController < ApplicationController
  def index
    videos = Video.all
    render json: videos
  end

  def show
    video = Video.find_by(public_id: params[:id])
    render json: video
  end
end
