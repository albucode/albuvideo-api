# frozen_string_literal: true

class VideoWatchEvent < ApplicationRecord
  belongs_to :video
  belongs_to :user

  validates :duration, numericality: { greater_than: 0 }
end
