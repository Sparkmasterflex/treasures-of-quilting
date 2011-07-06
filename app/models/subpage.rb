class Subpage < ActiveRecord::Base
  belongs_to :webpage

  has_many :images, :as => :attachable do
    def enabled
      find(:all, :conditions => {:enabled => true}, :order => :position)
    end

    def first_enabled
      find(:first, :conditions => {:enabled => true }, :order => :position)
    end
  end

  has_many :widgets, :as => :gadget do
    def js_slideshow
      find(:first, :conditions => {:widget => Widget::Template::SLIDESHOW, :enabled => true})
    end

    def js_gallery
      find(:first, :conditions => {:widget => Widget::Template::GALLERY, :enabled => true})
    end
  end

  accepts_nested_attributes_for :images

  before_validation :set_parent
  before_save :create_page_alias
  
  validates :page_title, :preview_text, :template, :parent, :presence => true

  def self.create_page_attribute(title)
    title.gsub(" ", "_").downcase
  end

  def limit_text
    self.text.slice!(0..150) + "..."
  end

  def has_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id}).any? #self.image_ids.any?
  end

  def has_enabled_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_type => "Subpage", :attachable_id => self.id, :enabled => true}).any? #self.image_ids.any?
  end

  def other_subpages
    self.webpage.subpages.reject { |sub| sub == self }
  end

  def link_class
    self.enabled ? nil : 'disabled'
  end

  def last_updated_by
    user = User.find(self.updated_by)
    return "#{user.first_name} #{user.last_name}"
  end
  
  def current(page)
    'current' if self.parent == page
  end

  private

  def set_parent
    self.webpage_id.blank? ?
      (errors.add :parent, ": Subpages must have a parent") :
      self.send("parent=", Webpage.find(self.webpage_id).page_alias)
  end

  def create_page_alias
    self.send("page_alias=", self.page_title.downcase.gsub!(/[ ,-]/, "_"))
  end
end
