# frozen_string_literal: true

class CreateInvoiceJob < ApplicationJob
  queue_as :default

  def perform
    invoice = Invoice.create!(start_date: DateTime.now, end_date: DateTime.now, user_id: 1, status: 0)
    InvoiceItem.create!(service_id: 1, quantity: 1.0, invoice_id: invoice.id, user_id: 1, price: 9.99)
  end
end
