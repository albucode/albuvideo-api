# frozen_string_literal: true

class SplitVariantIntoSegmentsJob < ApplicationJob
  queue_as :default

  def perform(variant_id)
    variant = Variant.find(variant_id)
    SplitVariantIntoSegments.perform(variant)
  end
end
