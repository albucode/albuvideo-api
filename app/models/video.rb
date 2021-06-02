# frozen_string_literal: true

class Video < ApplicationRecord
  enum status: { processing: 0, ready: 1, failed: 2 }

  validates :published, :source, :status, presence: true
end
