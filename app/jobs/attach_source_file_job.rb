# frozen_string_literal: true

class AttachSourceFileJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find(video_id)
    AttachSourceFile.perform(video)
  end
end
