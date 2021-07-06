# frozen_string_literal: true

class TranscodeSourceFile
  def self.perform(video)
    variant = Variant.create!(height: 1080, width: 1920, video_id: video.id, bitrate: 1)

    video.source_file.open do |file|
      input_file_path = file.path
      output_file_path = "/tmp/#{video.public_id}.mp4"
      system "ffmpeg -i #{input_file_path} -y -c:v libx264 -crf 22 -pix_fmt +yuv420p -vf scale=1920x1080 -b:a 192k #{output_file_path}"

      transcoded_file = File.open(output_file_path)

      variant.transcoded_file.attach(io: transcoded_file, filename: "#{variant.public_id}.mp4")
      File.delete(transcoded_file.path)
    end
  end
end
