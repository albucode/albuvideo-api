# frozen_string_literal: true

class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :published, :source

  def id
    object.public_id
  end
end
