# frozen_string_literal: true

class WebhookSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :topic, :url, :created_at

  def id
    object.public_id
  end
end
