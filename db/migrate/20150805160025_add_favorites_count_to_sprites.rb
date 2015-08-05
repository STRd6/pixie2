class AddFavoritesCountToSprites < ActiveRecord::Migration
  def up
    add_column :sprites, :favorites_count, :integer, :default => 0, :null => false

    Sprite.select(:id).find_each do |sprite|
      Sprite.reset_counters sprite.id, :favorites
    end
  end

  def down
    remove_column :sprites, :favorites_count
  end
end
