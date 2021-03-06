# frozen_string_literal: true

class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :start_date, :end_date, :public_id, :status, :invoice_total
  has_many :invoice_items

  def id
    object.public_id
  end
end
