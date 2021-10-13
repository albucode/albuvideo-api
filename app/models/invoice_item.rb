# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  include PublicId

  belongs_to :user
  belongs_to :service
  belongs_to :invoice

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, :price, presence: true
  validates :price, numericality: { greater_than: 0, less_than: 1_000 }

  def item_total
    quantity * price
  end
end
