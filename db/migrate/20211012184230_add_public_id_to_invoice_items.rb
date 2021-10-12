class AddPublicIdToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :public_id, :string, limit: 10, null: false
    add_index :invoice_items, :public_id, unique: true
  end
end
