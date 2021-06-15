# frozen_string_literal: true

class AccessToken < ApplicationRecord
  include PublicId

  belongs_to :user

  after_initialize do
    self.access_token = SecureRandom.alphanumeric(32) if access_token.nil?
  end

  validates :access_token, :name, presence: true

  validates :access_token, uniqueness: true

  validates :access_token, length: { is: 32 }
end
