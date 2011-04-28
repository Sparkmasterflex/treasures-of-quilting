class AddPreviewText < ActiveRecord::Migration
  def self.up
    add_column :webpages, :preview_text, :text
    add_column :subpages, :preview_text, :text
  end

  def self.down
    remove_column :webpages, :preview_text
    remove_column :subpages, :preview_text
  end
end
