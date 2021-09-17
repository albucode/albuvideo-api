# frozen_string_literal: true

class WebhookSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :topic, :url, :created_at, :options

  def id
    object.public_id
  end

  def options
    object.topic_values
  end
end
