class Api::VideosController < ApplicationController
  before_action :find_video, except: [:index]

  def index
    videos = Video.all
    render json: videos
  end

  def show
    render json: @video
  end

  def destroy
    if @video.destroy
      render json: {}
    else
      render json: { message: 'This video could not be deleted' }
    end
  end

  private

  def find_video
    @video = Video.find_by(public_id: params[:id])
  end
end
