class ContactStatus < ActiveRecord::Migration
  def self.up
    add_column :contacts, :status, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :contacts, :status
  end
end
