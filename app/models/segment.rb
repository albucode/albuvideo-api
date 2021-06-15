# frozen_string_literal: true

class Segment < ApplicationRecord
  belongs_to :variant

  validates :position, :duration, numericality: { greater_than: 0 }

  validates :position, uniqueness: { scope: :variant_id }
end
