class Api::VideosController < ApplicationController
  def index
    videos = Video.all
    render json: videos
  end

  def show
    video = Video.find_by(public_id: params[:id])
    render json: video
  end

  def destroy
    video = Video.find_by(public_id: params[:id])
    if video.destroy
      render json: {}
    else
      render json: { message: 'This video could not be deleted' }
    end
  end
end
