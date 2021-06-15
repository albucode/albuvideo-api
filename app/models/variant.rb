# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :video
  has_many :segments, dependent: :destroy

  after_initialize do
    self.public_id = SecureRandom.alphanumeric(10) if public_id.nil?
  end

  validates :public_id, presence: true

  validates :public_id, uniqueness: true

  validates :public_id, length: { is: 10 }

  validates :height, :width, :bitrate, numericality: { greater_than: 0 }
end
