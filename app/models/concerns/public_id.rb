# frozen_string_literal: true

module PublicId
  extend ActiveSupport::Concern

  included do
    after_initialize do
      self.public_id = SecureRandom.alphanumeric(10) if public_id.nil?
    end

    validates :public_id, presence: true

    validates :public_id, uniqueness: true

    validates :public_id, length: { is: 10 }
  end
end
