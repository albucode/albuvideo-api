# frozen_string_literal: true

class SignatureKeySerializer < ActiveModel::Serializer
  attributes :id, :name, :signature_key, :created_at

  def id
    object.public_id
  end
end
