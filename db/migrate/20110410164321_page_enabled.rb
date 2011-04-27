class PageEnabled < ActiveRecord::Migration
  def self.up
    add_column :webpages, :enabled, :boolean, :null => false, :default => 1
    add_column :subpages, :enabled, :boolean, :null => false, :default => 1
  end

  def self.down
    remove_column :webpages, :enabled
    remove_column :subpages, :enabled
  end
end
