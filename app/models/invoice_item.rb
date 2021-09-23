# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :invoice

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true
end
