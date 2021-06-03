# frozen_string_literal: true

class Video < ApplicationRecord
  after_initialize do
    self.public_id = SecureRandom.alphanumeric(10) if public_id.nil?
  end

  enum status: { processing: 0, ready: 1, failed: 2 }, _default: :processing

  validates :source, :status, :public_id, presence: true

  validates :published, inclusion: { in: [true, false]}

  validates :public_id, uniqueness: true

  validates :public_id, length: { is: 10 }
end
