# frozen_string_literal: true

class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.references :variant, null: false, foreign_key: true
      t.integer :position, null: false
      t.float :duration, null: false

      t.timestamps
    end

    add_index :segments, %i[position variant_id], unique: true
  end
end
