# frozen_string_literal: true

class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :published, :source, :created_at, :total_stream_time, :stream_time_last_24h,
             :playlist_url

  def playlist_url
    "http://localhost:8000/videos/#{id}.m3u8"
  end

  def id
    object.public_id
  end
end
