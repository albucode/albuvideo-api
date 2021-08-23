# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :country_permissions, dependent: :destroy
  has_many :videos, through: :country_permissions
end
