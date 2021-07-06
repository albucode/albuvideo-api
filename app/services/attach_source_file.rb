# frozen_string_literal: true

require 'down'

class AttachSourceFile
  def self.perform(video)
    tempfile = Down.download(video.source)
    path = tempfile.path
    extension = File.extname(path)
    video.source_file.attach(io: tempfile, filename: "#{video.public_id}#{extension}")
    File.delete(path)
  end
end
