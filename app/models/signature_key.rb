# frozen_string_literal: true

class SignatureKey < ApplicationRecord
  include PublicId

  belongs_to :user

  after_initialize do
    self.signature_key = SecureRandom.alphanumeric(64) if signature_key.nil?
  end

  validates :signature_key, :name, presence: true

  validates :signature_key, uniqueness: true

  validates :signature_key, length: { is: 64 }
end
