class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
    	t.integer :user_id, index: true
         t.integer :bet
         
      t.timestamps null: false
    end
  end
end
