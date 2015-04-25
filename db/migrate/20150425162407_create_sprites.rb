class CreateSprites < ActiveRecord::Migration
  def change
    create_table :sprites do |t|
      t.integer :width
      t.integer :height
      t.references :owner, index: true, foreign_key: true
      t.references :parent, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :image_url

      t.timestamps null: false
    end
  end
end
