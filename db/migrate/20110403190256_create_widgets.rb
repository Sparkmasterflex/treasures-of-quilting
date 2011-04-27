class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.integer :gadget_id, :null => false
      t.string  :gadget_type, :null => false
      t.integer :widget, :null => false
      t.boolean :enabled, :null => false, :default => false
      t.integer :position, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :widgets
  end
end
