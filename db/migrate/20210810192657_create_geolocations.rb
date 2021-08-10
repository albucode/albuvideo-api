# frozen_string_literal: true

class CreateGeolocations < ActiveRecord::Migration[6.1]
  def change
    create_table :geolocations do |t|
      t.integer :ip_from
      t.integer :ip_to
      t.string :country_code
      t.string :country
      t.string :region
      t.string :city

      t.timestamps
    end
    add_index :geolocations, :ip_from
    add_index :geolocations, :ip_to
    add_index :geolocations, :country_code
  end
end
