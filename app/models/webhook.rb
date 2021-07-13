# frozen_string_literal: true

class Webhook < ApplicationRecord
  include PublicId

  belongs_to :user

  validates :topic, :url, presence: true
  validates :url, url: true
  validates :topic, acceptance: { accept: %w[video/ready video/failed] }
end
