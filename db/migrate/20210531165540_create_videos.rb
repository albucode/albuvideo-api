class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.boolean :published
      t.integer :status
      t.string :source

      t.timestamps
    end
  end
end
