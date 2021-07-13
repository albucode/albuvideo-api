# frozen_string_literal: true

class Video < ApplicationRecord
  include AASM
  include PublicId

  aasm column: 'status' do
    state :processing, initial: true
    state :ready

    event :process do
      transitions from: :processing, to: :ready
    end
  end

  belongs_to :user
  has_many :variants, dependent: :destroy
  has_many :video_watch_events, dependent: :destroy
  has_one_attached :source_file

  enum status: { processing: 0, ready: 1, failed: 2 }, _default: :processing

  validates :source, :status, presence: true

  validates :published, inclusion: { in: [true, false] }
end
