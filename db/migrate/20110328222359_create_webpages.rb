class CreateWebpages < ActiveRecord::Migration
  def self.up
    create_table :webpages do |t|
      t.string    :page_alias
      t.integer   :template, :null => false, :default => 20
      t.string    :page_title
      t.text      :text
      t.integer   :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :webpages
  end
end
