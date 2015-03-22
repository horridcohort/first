class AddAcceptedToDare < ActiveRecord::Migration
  def change
  	add_column :dares, :accepted, :boolean, default: false
  end
end
