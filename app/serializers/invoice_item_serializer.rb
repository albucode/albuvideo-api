# frozen_string_literal: true

class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :user_id, :service_id, :price, :invoice_id, :item_total

  def item_total
    object.quantity * object.price
  end
end
