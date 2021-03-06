class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string  :title
      t.string  :description
      t.date 		:date
      t.integer :user_id

      t.timestamps
    end	
    add_index :collections, [:user_id, :created_at]
  end
end
