# frozen_string_literal: true

class Service < ApplicationRecord
  enum category: { streaming: 0 }

  validates :name, :category, :description, :price, presence: true
  validates :name, uniqueness: true

  has_many :subscriptions, dependent: :nullify
end
