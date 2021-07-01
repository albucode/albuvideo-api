# frozen_string_literal: true

class CreateVideoWatchEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :video_watch_events do |t|
      t.references :video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :duration, null: false

      t.timestamps
    end
  end
end
