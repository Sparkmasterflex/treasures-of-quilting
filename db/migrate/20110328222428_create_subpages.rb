class CreateSubpages < ActiveRecord::Migration
  def self.up
    create_table :subpages do |t|
      t.integer   :webpage_id
      t.string   :parent
      t.string    :page_alias
      t.integer   :template, :null => false, :default => 20
      t.string    :page_title
      t.text      :text
      t.integer   :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :subpages
  end
end
