# frozen_string_literal: true

class AddCountryPermissionTypeToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :country_permission_type, :integer
  end
end
