class AddPublicIdToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :public_id, :string, limit: 10, null: false
    add_index :videos, :public_id, unique: true
  end
end
