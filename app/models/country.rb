# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :country_permissions, dependent: :destroy
  has_many :videos, through: :country_permissions

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
