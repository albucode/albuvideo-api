# frozen_string_literal: true

require 'down'

class VideosController < ApplicationController
  before_action :find_video, except: %i[index create]
  before_action :authenticate_user!

  def create
    video = Video.new video_params
    video.user_id = current_user.id
    if video.save
      tempfile = Down.download(video.source)
      video.source_file.attach(io: tempfile, filename: "#{video.public_id}#{File.extname(tempfile.path)}")
      File.delete(tempfile.path)

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

  private

  def find_video
    @video = Video.find_by!(public_id: params[:id], user: current_user)
  end

  def video_params
    params.require(:video).permit(:title, :published, :source)
  end
end
