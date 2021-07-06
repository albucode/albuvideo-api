# frozen_string_literal: true

require 'down'

class AttachSourceFile
  def self.perform(video)
    tempfile = Down.download(video.source)
    path = tempfile.path
    extension = File.extname(path)
    video.source_file.attach(io: tempfile, filename: "#{video.public_id}#{extension}")
    File.delete(path)

    variant = Variant.create!(height: 1080, width: 1920, video_id: video.id, bitrate: 1)

    video.source_file.open do |file|
      input_file_path = file.path
      output_file_path = "/tmp/#{video.public_id}.mp4"
      system "ffmpeg -i #{input_file_path} -y -c:v libx264 -crf 22 -pix_fmt +yuv420p -vf scale=1920x1080 -b:a 192k #{output_file_path}"

      transcoded_file = File.open(output_file_path)

      variant.transcoded_file.attach(io: transcoded_file, filename: "#{video.public_id}.mp4")
    end
  end
end
