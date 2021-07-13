# frozen_string_literal: true

class WebhookSerializer < ActiveModel::Serializer
  attributes :id, :topic, :url, :created_at

  def id
    object.public_id
  end
end
