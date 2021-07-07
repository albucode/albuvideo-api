# frozen_string_literal: true

class SplitVariantIntoSegments
  def self.perform(variant)
    variant.transcoded_file.open do |file|
      input_path = file.path
      segment_path = "/tmp/#{variant.public_id}_segment_%01d.ts"
      playlist_path = "/tmp/#{variant.public_id}_playlist.m3u8"

      system(
        "ffmpeg -i #{input_path} -y -c:v copy -c:a copy -vbsf h264_mp4toannexb -hls_time 6 -hls_list_size 0 -hls_segment_filename #{segment_path} #{playlist_path}",
        exception: true
      )

      # segment_file = File.open(segment_path)
      #
      # segment = Segment.create!(variant_id: variant.id, position: position, duration: duration)
      #
      # segment.segment_file.attach(io: segment_file, filename: "#{variant.public_id}_segment_#{segment_order_on_playlist}.ts")
    end
  end
end
