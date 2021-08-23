# frozen_string_literal: true

class CountryPermission < ApplicationRecord
  belongs_to :country
  belongs_to :video
end
