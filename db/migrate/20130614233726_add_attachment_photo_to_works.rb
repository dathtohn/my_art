class AddAttachmentPhotoToWorks < ActiveRecord::Migration
  def self.up
    change_table :works do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :works, :photo
  end
end
