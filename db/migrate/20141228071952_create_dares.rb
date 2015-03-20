class CreateDares < ActiveRecord::Migration
  def change
    create_table :dares do |t|

    t.integer  :sender_id
    t.integer  :recipient_id
    t.integer  :user_id, index: true
    t.integer   :bet
    t.text     :body
    t.integer  :won_id, index: true
    t.integer  :lost_id, index: true
    t.integer  :issued_id, index: true
    t.timestamps null: false
  end
     add_index :dares, [:sender_id, :created_at]
     add_index :dares, [:recipient_id, :created_at]
  end
end
