# frozen_string_literal: true

class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :user_id, :service_id, :price, :item_total

  def id
    object.public_id
  end
end

