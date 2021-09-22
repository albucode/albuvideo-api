# frozen_string_literal: true

class Invoice < ApplicationRecord
  include PublicId

  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  enum status: { pending: 0, paid: 1 }, _default: :pending

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
