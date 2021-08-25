# frozen_string_literal: true

class AddSessionIdToVideoStreamEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :video_stream_events, :session_id, :string
  end
end
