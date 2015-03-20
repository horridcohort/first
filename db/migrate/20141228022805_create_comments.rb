class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.text :name, index: true
      t.integer :post_id
      t.integer :user_id, index: true
      t.timestamps null: false
    end
    add_index :comments, [:post_id, :created_at]
    add_index :comments, [:user_id, :created_at]
  
      end
end
