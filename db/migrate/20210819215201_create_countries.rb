# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end
    add_index :countries, :code, unique: true
  end
end
