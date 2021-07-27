# frozen_string_literal: true

class VideoStatsController < ApplicationController
  def show
    query = <<~SQL.squish
      SELECT sum(duration), time_bucket_gapfill('1 hour', created_at) AS period
      FROM video_stream_events
      WHERE created_at BETWEEN NOW() - interval '24 hours' AND NOW()
      GROUP BY period;
    SQL
    render json: ActiveRecord::Base.connection.execute(query).to_a
  end
end
