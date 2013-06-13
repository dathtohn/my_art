class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string	:title
      t.string	:description
      t.integer :collection_id

      t.timestamps
    end
  end
end
