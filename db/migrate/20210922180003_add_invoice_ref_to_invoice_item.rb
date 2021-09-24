# frozen_string_literal: true

class AddInvoiceRefToInvoiceItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :invoice_items, :invoice, index: true, foreign_key: true
  end
end
