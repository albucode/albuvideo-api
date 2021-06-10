# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :access_tokens do |t|
      t.string :name
      t.string :access_token, limit: 32, null: false
      t.string :public_id, limit: 10, null: false
      t.references :user, null: false, foreign_key: true
      t.index :access_token, unique: true
      t.index :public_id, unique: true

      t.timestamps
    end
  end
end
