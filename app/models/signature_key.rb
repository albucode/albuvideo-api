# frozen_string_literal: true

class SignatureKey < ApplicationRecord
  belongs_to :user

  after_initialize do
    self.public_id = SecureRandom.alphanumeric(10) if public_id.nil?
  end

  after_initialize do
    self.signature_key = SecureRandom.alphanumeric(64) if signature_key.nil?
  end

  validates :signature_key, :public_id, :name, presence: true

  validates :signature_key, :public_id, uniqueness: true

  validates :signature_key, length: { is: 64 }

  validates :public_id, length: { is: 10 }
end
