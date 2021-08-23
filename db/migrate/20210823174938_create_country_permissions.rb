# frozen_string_literal: true

class CreateCountryPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :country_permissions do |t|
      t.references :country, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
