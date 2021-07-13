# frozen_string_literal: true

class CreateWebhooks < ActiveRecord::Migration[6.1]
  def change
    create_table :webhooks do |t|
      t.string :topic, null: false
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true
      t.string :public_id, unique: true

      t.timestamps
    end
  end
end
