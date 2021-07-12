# frozen_string_literal: true

require 'down'

class AttachSourceFile
  def self.perform(video)
    tempfile = Down.download(video.source)
    path = tempfile.path
    extension = File.extname(path)
    video.source_file.attach(io: tempfile, filename: "#{video.public_id}#{extension}")
    File.delete(path)

    TranscodeSourceFileJob.perform_later(video.id, 1920, 1080)
    TranscodeSourceFileJob.perform_later(video.id, 1280, 720)
    TranscodeSourceFileJob.perform_later(video.id, 852, 480)
  end
end
