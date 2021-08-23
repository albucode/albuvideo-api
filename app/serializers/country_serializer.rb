# frozen_string_literal: true

class CountrySerializer < ActiveModel::Serializer
  attributes :value, :label

  def value
    object.id
  end

  def label
    object.name
  end
end
