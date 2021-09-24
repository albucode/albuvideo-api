# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.references :user, null: false, foreign_key: true
      t.timestamp :start_date, null: false
      t.timestamp :end_date, null: false
      t.string :public_id, null: false
      t.integer :status, null: false

      t.timestamps
    end
    add_index :invoices, :public_id, unique: true
  end
end
