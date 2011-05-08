class UserRole < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :users, :role
  end
end
