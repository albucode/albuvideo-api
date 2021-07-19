# frozen_string_literal: true

class SendVideoStatusWebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook_subscription_id, video_id)
    video = Video.find(video_id)
    webhook_subscription = WebhookSubscription.find(webhook_subscription_id)
    SendVideoStatusWebhook.perform(webhook_subscription, video)
  end
end
