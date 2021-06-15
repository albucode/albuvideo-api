# frozen_string_literal: true

class Variant < ApplicationRecord
  include PublicId

  belongs_to :video
  has_many :segments, dependent: :destroy

  validates :height, :width, :bitrate, numericality: { greater_than: 0 }
end
