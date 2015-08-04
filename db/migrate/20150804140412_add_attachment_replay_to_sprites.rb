class AddAttachmentReplayToSprites < ActiveRecord::Migration
  def self.up
    change_table :sprites do |t|
      t.attachment :replay
    end
  end

  def self.down
    remove_attachment :sprites, :replay
  end
end
