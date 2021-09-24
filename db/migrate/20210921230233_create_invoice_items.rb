# frozen_string_literal: true

class CreateInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_items do |t|
      t.float :quantity, null: false
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
