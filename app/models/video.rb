# frozen_string_literal: true

class Video < ApplicationRecord
  after_initialize do |video|
    video.public_id = SecureRandom.alphanumeric(10)
  end

  enum status: { processing: 0, ready: 1, failed: 2 }

  validates :published, :source, :status, presence: true
end
