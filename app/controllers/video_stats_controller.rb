# frozen_string_literal: true

class VideoStatsController < ApplicationController
  before_action :authenticate_user!

  def show
    query = <<~SQL.squish
      SELECT sum(duration), time_bucket_gapfill('1 hour', video_stream_events.created_at) AS period
      FROM video_stream_events
      LEFT JOIN videos v on video_stream_events.video_id = v.id
      WHERE(public_id = '#{params[:video_id]}' AND video_stream_events.created_at BETWEEN NOW() - interval '48 hours' AND NOW())
      GROUP BY period;
    SQL
    render json: ActiveRecord::Base.connection.execute(query).to_a
  end
end
