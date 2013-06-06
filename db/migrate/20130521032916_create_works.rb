class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string	:title
      t.integer :collection_id
      t.string	:link

      t.timestamps
    end
  end
end
