class Widget < ActiveRecord::Base
  belongs_to :gadget, :polymorphic => true

  class Template
    SLIDESHOW            = 10
    CONTACT              = 20
    NEW_PRODUCTS         = 30
    FEATURED_PRODUCTS    = 40
    CALCULATOR           = 50
    FEATURED_PAGE        = 60
    GALLERY              = 70

    LABELS = {SLIDESHOW => 'Slideshow', CONTACT => 'Contact Form', NEW_PRODUCTS => 'New Products', FEATURED_PRODUCTS => 'Featured Products',
              CALCULATOR => 'Calculator', FEATURED_PAGE => 'Featured Page', GALLERY => 'Gallery'}

    TEMPLATES = {SLIDESHOW => 'js_slideshow', CONTACT => 'contact_form', NEW_PRODUCTS => 'new_products', FEATURED_PRODUCTS => 'featured_products',
                 CALCULATOR => 'calculator', FEATURED_PAGE => 'featured_page', GALLERY => 'js_gallery'}
    def self.options_for_select
      lbl = LABELS.reject { |key, value| [SLIDESHOW, GALLERY].include? key }.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end

  before_save :unique_image_display

  def self.destroy_widget(obj)
    self.find(:first, :conditions => {:gadget_id => obj.id, :gadget_type => obj.class.to_s, :widget => [Template::SLIDESHOW, Template::GALLERY]}).destroy
  end

  def self.available_featured_pages(page)
    available = {}
    web_conditions = page.is_a?(Webpage) ? ['is_root = false AND id != ?', page.id] : {:is_root => false}

    options = {:order => :created_at}
    options.merge!({:condition => ['id != ?', page.id]}) if page.is_a?(Subpage)

    Webpage.find(:all, :conditions => web_conditions).each { |web| available.merge!({web.page_title => "Webpage_#{web.id}"}) }
    Subpage.find(:all, options).each { |sub| available.merge!({sub.page_title => "Subpage_#{sub.id}"}) }

    available
  end
  
  private
  
  def unique_image_display    
    if [Template::SLIDESHOW, Template::GALLERY].include? self.widget
      prev = Widget.find(:first, :conditions => {:gadget_id => self.gadget_id, :gadget_type => self.gadget_type, :widget => [Template::SLIDESHOW, Template::GALLERY]})
      prev.destroy unless prev.nil?
    end
  end
end
