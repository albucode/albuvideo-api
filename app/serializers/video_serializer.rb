# frozen_string_literal: true

class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :published, :source, :created_at, :total_stream_time, :stream_time_last_24h

  def id
    object.public_id
  end
end
