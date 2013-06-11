class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string	:title
      t.date 		:date
      t.string	:link
      t.integer :user_id

      t.timestamps
    end	
    add_index :collections, [:user_id, :created_at]
  end
end
