# frozen_string_literal: true

class TranscodeSourceFile
  def self.perform(video, width, height)
    variant = Variant.create!(width: width, height: height, video_id: video.id, bitrate: 1)

    video.source_file.open do |file|
      input_file_path = file.path
      output_file_path = "/tmp/#{variant.public_id}.mp4"
      system(
        "ffmpeg -i #{input_file_path} -y -c:v libx264 -crf 22 -pix_fmt +yuv420p "\
        "-vf scale=#{width}x#{height} -b:a 192k #{output_file_path}",
        exception: true
      )

      transcoded_file = File.open(output_file_path)

      variant.transcoded_file.attach(io: transcoded_file, filename: "#{variant.public_id}.mp4")
      File.delete(transcoded_file.path)

      SplitVariantIntoSegmentsJob.perform_later(variant.id)
    end
  end
end
