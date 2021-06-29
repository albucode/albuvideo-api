# frozen_string_literal: true

class VideoWatchEvent < ApplicationRecord
  belongs_to :video
end
