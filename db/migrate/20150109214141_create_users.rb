class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :points_count, :default => 0 
      t.integer :posts_count, :default => 0 
      t.integer :bet
      t.integer :position, index: true

      t.timestamps null: false
    end
  end
end
