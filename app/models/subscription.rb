# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :invoice
end
