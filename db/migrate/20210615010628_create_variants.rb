# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.references :video, null: false, foreign_key: true
      t.string :public_id
      t.integer :height
      t.integer :width
      t.integer :bitrate
      t.index :public_id, unique: true

      t.timestamps
    end
  end
end
