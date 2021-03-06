# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :find_video, except: %i[index create]
  before_action :authenticate_user!

  def create
    video = Video.new video_params
    video.user_id = current_user.id
    if video.save
      AttachSourceFileJob.perform_later(video.id)
      render json: video, status: :created
    else
      render(
        json: { errors: video.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def index
    videos = Video.where(user_id: current_user.id).order(created_at: :desc)
    render json: videos
  end

  def show
    render json: @video
  end

  def destroy
    if @video.destroy
      render json: {}
    else
      render(
        json: { errors: @video.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  def update
    if @video.update update_video_params
      render json: @video
    else
      render(
        json: { errors: @video.errors.full_messages },
        status: :unprocessable_entity
      )
    end
  end

  private

  def find_video
    @video = Video.find_by!(public_id: params[:id], user: current_user)
  end

  def video_params
    params.require(:video).permit(:title, :published, :source, :country_permission_type, country_ids: [])
  end

  def update_video_params
    params.require(:video).permit(:title, :published, :country_permission_type, country_ids: [])
  end
end
