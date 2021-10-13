# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.integer :category, null: false
      t.string :description, null: false
      t.decimal :price, precision: 15, scale: 4, null: false

      t.timestamps
    end
    add_index :services, :name, unique: true
  end
end
