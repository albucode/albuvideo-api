# frozen_string_literal: true

class AccessTokenSerializer < ActiveModel::Serializer
  attributes :id, :name, :access_token, :created_at

  def id
    object.public_id
  end
end
