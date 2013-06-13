class AddAttachmentCoverToCollections < ActiveRecord::Migration
  def self.up
    change_table :collections do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :collections, :cover
  end
end
