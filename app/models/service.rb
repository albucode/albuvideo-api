# frozen_string_literal: true

class Service < ApplicationRecord
  enum category: { streaming: 0, other: 1 }

  has_many :invoice_items, dependent: :nullify

  validates :name, :category, :description, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0, less_than: 1_000 }
end
