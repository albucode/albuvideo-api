# frozen_string_literal: true

class AccessToken < ApplicationRecord
  belongs_to :user

  after_initialize do
    self.public_id = SecureRandom.alphanumeric(10) if public_id.nil?
  end

  after_initialize do
    self.access_token = SecureRandom.alphanumeric(32) if access_token.nil?
  end

  validates :access_token, :public_id, :name, presence: true

  validates :access_token, :public_id, uniqueness: true

  validates :access_token, length: { is: 32 }

  validates :public_id, length: { is: 10 }
end
