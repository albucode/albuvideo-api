# frozen_string_literal: true

class CreateSignatureKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :signature_keys do |t|
      t.string :name, null: false
      t.string :signature_key, limit: 64, null: false
      t.string :public_id, limit: 10, null: false
      t.references :user, null: false, foreign_key: true
      t.index :signature_key, unique: true
      t.index :public_id, unique: true

      t.timestamps
    end
  end
end
