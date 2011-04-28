class IsRoot < ActiveRecord::Migration
  def self.up
    add_column :webpages, :is_root, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :webpages, :is_root
  end
end
