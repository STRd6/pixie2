class CollectionItem < ActiveRecord::Base
  belongs_to :collection
  belongs_to :item, :polymorphic => true, :counter_cache => :favorites_count

  scope :find_by_item, lambda { |item|
    where("collection_items.item_id = ? AND collection_items.item_type = ?", item.id, item.class.to_s)
  }
end
