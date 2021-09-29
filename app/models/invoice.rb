# frozen_string_literal: true

class Invoice < ApplicationRecord
  include PublicId

  belongs_to :user
  has_many :invoice_items, dependent: :destroy

  enum status: { pending: 0, paid: 1 }, _default: :pending
end
