# frozen_string_literal: true

class CreateWebhookSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :webhook_subscriptions do |t|
      t.string :topic, null: false
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true
      t.string :public_id, null: false
      t.index :public_id, unique: true

      t.timestamps
    end
  end
end
