class Image < ActiveRecord::Base
  class ContentType
    IMAGES = ["image/png", "image/x-png", "image/jpg", "image/jpeg",
              "image/pjpeg", "image/gif", "image/bmp", "image/tiff"]
    DOCUMENTS = ["application/pdf", "text/plain", "application/msword", "application/vnd.ms-excel",
                 "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                 "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]

    def self.allowed_types
      IMAGES + DOCUMENTS
    end
  end

  belongs_to :attachable, :polymorphic => true

  has_attached_file :attachment,
    :path          => ":rails_root/public/images/uploaded/:attachable_type/:attachable_id/:id_:style.:extension",
    :url           => "/images/uploaded/:attachable_type/:attachable_id/:id_:style.:extension",
    :styles        => lambda { |attachment| ContentType::IMAGES.include?(attachment.instance_read(:content_type)) ? { :thumb => ["80x80>", :jpg], :sm_preview => ["138x138>", :jpg], :slideshow => ["340x350>", :jpg], :popup => ["850x612>", :jpg] } : {} },
    :default_style => :small

  validates_attachment_size :attachment, :in => 1.kilobytes..24.megabytes
  validates_attachment_content_type :attachment, :content_type => ContentType.allowed_types

#  after_update :move_imported_scan

  # Alias for original_filename
  def filename
    attachment.original_filename
  end

  def is_image?
    ContentType::IMAGES.include?(self.content_type)
  end

  def enabled?
    self.enabled == true
  end

  def attached_to
    attachable_type = self.attachable_type.constantize.find(:first, :conditions => {:id => self.attachable_id})

    attachable_type.is_a?(Project) ? attachable_type.feature_with(self.id) : attachable_type
  end

  def can_attach?
    self.attached_to.blank?
  end

  def reorder_images(obj, to)
    others = obj.images.reject { |img| img.id == self.id }.sort_by { |o| o.position  }
    self.update_attribute('position', to)
    others.each { |o| o.update_attribute('position', to += 1) if o.position >= to }
  end

  def method_missing(sym, *args, &block)
    if attachment.respond_to?(sym)
      attachment.send(sym, *args, &block)
    else
      super(sym, *args, &block)
    end
  end
end
