class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.integer :user_id, index: true
    	t.integer :dare_id, index: true

      t.timestamps null: false
    end
    add_index :videos, [:user_id, :created_at]
    add_index :videos, [:dare_id, :created_at]
  end
end
