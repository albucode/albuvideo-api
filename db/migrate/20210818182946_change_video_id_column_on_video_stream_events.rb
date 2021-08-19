# frozen_string_literal: true

class ChangeVideoIdColumnOnVideoStreamEvents < ActiveRecord::Migration[6.1]
  def change
    change_column_null :video_stream_events, :video_id, true
  end
end
