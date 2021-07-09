# frozen_string_literal: true

require 'm3u8'

class SplitVariantIntoSegments
  def self.perform(variant)
    playlist_path = "/tmp/#{variant.public_id}_playlist.m3u8"
    segment_path = "/tmp/#{variant.public_id}_segment_%01d.ts"

    variant.transcoded_file.open do |file|
      input_path = file.path
      system(
        "ffmpeg -i #{input_path} -y -c:v copy -c:a copy -vbsf h264_mp4toannexb -hls_time 6 -hls_list_size 0 -hls_segment_filename #{segment_path} #{playlist_path}",
        exception: true
      )
    end

    playlist_file = File.open(playlist_path)
    playlist = M3u8::Playlist.read(playlist_file)

    create_segments(playlist, variant)
  end

  def self.create_segments(playlist, variant)
    playlist.items.each_with_index do |item, index|
      segment = Segment.create!(variant_id: variant.id, position: index, duration: item.duration)
      segment.segment_file.attach(io: File.open("/tmp/#{item.segment}"), filename: item.segment)
    end
  end
end
