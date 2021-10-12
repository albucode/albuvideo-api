# frozen_string_literal: true

class CreateInvoiceJob < ApplicationJob
  queue_as :default

  def perform
    service = Service.find_by(category: 'streaming')
    beginning_of_last_month = Time.zone.now.last_month.beginning_of_month
    end_of_last_month = Time.zone.now.last_month.end_of_month
    User.all.each do |user|
      invoice = Invoice.create!(start_date: beginning_of_last_month, end_date: end_of_last_month, user_id: user.id,
                                status: :pending)
      InvoiceItem.create!(service_id: service.id,
                          quantity: streaming_time_in_minutes(user.id, beginning_of_last_month, end_of_last_month),
                          invoice_id: invoice.id, user_id: user.id,
                          price: service.price)
    end
  end

  private

  def streaming_time_in_minutes(id, start_date, end_date)
    VideoStreamEvent.where(user_id: id, created_at: start_date..end_date).sum(:duration) / 60
  end
end
