class Webpage < ActiveRecord::Base
  require 'calculator'
  
  has_many :subpages do
    def enabled
      find(:all, :conditions => {:enabled => true })
    end

    def limit(num)
      find(:all, :order => :created_at, :limit => num)
    end
  end

  has_many :images, :as => :attachable do
    def enabled
      find(:all, :conditions => {:enabled => true }, :order => :position)
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

    def for_page(enabled=[true,false], limit=nil)
      find(:all, :conditions => ['widget NOT IN (?) AND enabled IN (?)', [Widget::Template::GALLERY, Widget::Template::SLIDESHOW], enabled], :order => :position, :limit => limit)
    end
  end

  accepts_nested_attributes_for :subpages
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :widgets

  before_validation :create_page_alias
  before_save :unset_current_root

  validates :page_title, :preview_text, :presence => true

  def self.last_page_updated(user)
    self.find(:first, :conditions => {:updated_by => user.id}, :order => :updated_at) || "No pages updated by #{user.login}"
  end

  def self.subpages_for(webpage)
    self.find(:first, :conditions => {:page_alias => webpage}).subpages
  end

  def has_subpages?
    self.subpage_ids.any?
  end

  def has_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_id => self.id}).any? #self.image_ids.any?
  end

  def has_enabled_images?
    Image.find(:all, :select => 'id', :conditions => {:attachable_type => "Webpage", :attachable_id => self.id, :enabled => true}).any? #self.image_ids.any?
  end

  def self.find_webpage(page)
    find(:first, :conditions => {:page_alias => page})
  end

  def self.current_root
    @current_root ||= Webpage.find(:first, :conditions => {:is_root => true})
  end

  def self.all_webpages
    all_webpages = {}
    Webpage.all.collect{ |web| all_webpages.merge!({web.id => web.page_title}) }

    all_webpages.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
  end

  def link_class
    self.enabled ? nil : 'disabled'
  end

  def last_updated_by
    user = User.find(self.updated_by)
    return "#{user.first_name} #{user.last_name}"
  end

  def home_template?
    self.template == AppSystem::Templates::HOME
  end
  
  def current(page)
    'current' if self.page_alias == page
  end
  
  def calculator?
    self.page_alias == 'calculator'
  end

  private

  def create_page_alias    
    title = self.page_title.downcase
    page_alias = title =~ /about/ ? 'about' :                   
                   title =~ /service/ ? 'services' :
                     title =~ /store/ ? 'store' :
                       title =~ /contact/ ? 'contact' :
                         title =~ /(calcul|estimat)/ ? 'calculator' :
                           title.split(" ")[0]
    self.send("page_alias=", page_alias)
  end

  def unset_current_root
    if self.is_root
      current = Webpage.find(:first, :conditions => {:is_root => true})
      current.update_attribute('is_root', false) unless current.nil? || current == self
    end
  end
end
