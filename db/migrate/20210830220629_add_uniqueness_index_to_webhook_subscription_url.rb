# frozen_string_literal: true

class AddUniquenessIndexToWebhookSubscriptionUrl < ActiveRecord::Migration[6.1]
  def change
    add_index :webhook_subscriptions, %i[url topic user_id], unique: true
  end
end
