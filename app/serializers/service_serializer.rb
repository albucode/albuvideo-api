# frozen_string_literal: true

class ServiceSerializer < ActiveModel::Serializer
  attributes :name, :category, :description, :price
end
