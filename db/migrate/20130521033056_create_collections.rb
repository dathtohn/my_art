class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string	:title
      t.date 		:date
      t.string	:link

      t.timestamps
    end
  end
end
