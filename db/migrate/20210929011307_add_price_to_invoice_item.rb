# frozen_string_literal: true

class AddPriceToInvoiceItem < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :price, :decimal, precision: 15, scale: 4, null: false
    remove_column :invoices, :amount, :decimal
  end
end
