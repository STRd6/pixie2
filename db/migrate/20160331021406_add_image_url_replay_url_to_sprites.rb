class AddImageUrlReplayUrlToSprites < ActiveRecord::Migration
  def up
    add_column :sprites, :image_url, :string
    add_column :sprites, :replay_url, :string

    Sprite.select{[id, image_file_name]}.find_each(&:update_asset_urls)
  end

  def down
    remove_column :sprites, :image_url
    remove_column :sprites, :replay_url
  end
end
