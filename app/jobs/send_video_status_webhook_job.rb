# frozen_string_literal: true

class SendVideoStatusWebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook_subscription, video)
    SendVideoStatusWebhook.perform(webhook_subscription, video)
  end
end
