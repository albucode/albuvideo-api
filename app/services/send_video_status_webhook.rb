# frozen_string_literal: true

class SendVideoStatusWebhook
  def self.perform(webhook_subscription, video)
    if webhook_subscription
      RestClient.post webhook_subscription.url.to_s,
                      { video: ActiveModelSerializers::SerializableResource.new(video) }.to_json,
                      content_type: :json,
                      accept: :json
    end
  end
end
