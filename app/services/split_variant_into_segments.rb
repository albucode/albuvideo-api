# frozen_string_literal: true

require 'm3u8'

class SplitVariantIntoSegments
  class << self
    def perform(variant)
      playlist_path = "/tmp/#{variant.public_id}_playlist.m3u8"

      split_transcoded_file(variant, playlist_path)

      playlist_file = File.open(playlist_path)

      playlist = M3u8::Playlist.read(playlist_file)

      create_segments(playlist, variant)
      File.delete(playlist_path)
    end

    private

    def split_transcoded_file(variant, playlist_path)
      segment_path = "/tmp/#{variant.public_id}_segment_%01d.ts"

      variant.transcoded_file.open do |file|
        input_path = file.path
        system(
          "ffmpeg -i #{input_path} -y -loglevel error -c:v copy -c:a copy -vbsf h264_mp4toannexb -hls_time 6 -hls_list_size 0"\
          "-hls_segment_filename '#{segment_path}' #{playlist_path}",
          exception: true
        )
      end
       File.delete(segment_path)
    end

    def create_segments(playlist, variant)
      playlist.items.each_with_index do |item, index|
        segment = Segment.create!(variant_id: variant.id, position: index, duration: item.duration)

        segment.segment_file.attach(io: File.open("/tmp/#{item.segment}"), filename: item.segment)
        File.delete("/tmp/#{item.segment}")
      end
      video.process!
    end
  end
end
