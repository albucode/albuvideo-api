# frozen_string_literal: true

class Segment < ApplicationRecord
  belongs_to :variant

  has_one_attached :segment_file

  validates :duration, numericality: { greater_than: 0 }

  validates :position, uniqueness: { scope: :variant_id }, numericality: { greater_than_or_equal_to: 0 }
end
