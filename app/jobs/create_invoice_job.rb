# frozen_string_literal: true

class CreateInvoiceJob < ApplicationJob
  queue_as :default

  def perform
    service = Service.find_by(category: 'streaming')
    beginning_of_last_month = Time.zone.now.last_month.beginning_of_month
    end_of_last_month = Time.zone.now.last_month.end_of_month
    User.all.each do |user|
      invoice = Invoice.create!(start_date: beginning_of_last_month, end_date: end_of_last_month, user_id: user.id,
                                status: 0)
      InvoiceItem.create!(service_id: service.id, quantity: 1.0, invoice_id: invoice.id, user_id: user.id,
                          price: service.price)
    end
  end
end
