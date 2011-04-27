class CreateImages < ActiveRecord::Migration
    def self.up
    create_table :images do |t|
      t.integer  :attachable_id
      t.string   :attachable_type
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.integer  :attachment_file_size
      t.datetime :attachment_updated_at
      t.text     :caption, :limit => 500
      t.boolean  :enabled, :null => false, :default => false
      t.integer  :position, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
