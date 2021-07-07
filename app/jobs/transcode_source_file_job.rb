# frozen_string_literal: true

class TranscodeSourceFileJob < ApplicationJob
  queue_as :default

  def perform(video_id, width, height)
    video = Video.find(video_id)
    TranscodeSourceFile.perform(video, width, height)
  end
end
