# frozen_string_literal: true

class TranscodeSourceFileJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find(video_id)
    TranscodeSourceFile.perform(video)
  end
end
