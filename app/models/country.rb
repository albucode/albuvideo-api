# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :country_permissions
  has_many :videos, through: :country_permissions
end
