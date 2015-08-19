class AddEditorToSprites < ActiveRecord::Migration
  def change
    add_column :sprites, :editor, :string
  end
end
