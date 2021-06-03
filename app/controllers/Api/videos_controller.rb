class Api::VideosController < ApplicationController
  before_action :find_video, except: %i[index create]

  def create
    video = Video.new video_params
    if video.save
      render json: video, status: :created
    else
      render(
        json: { errors: video.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

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

  def video_params
    params.require(:video).permit(:title, :published, :source)
  end
end
