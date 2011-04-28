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
  end

  before_save :unique_image_display

  def self.destroy_widget(obj)
    self.find(:first, :conditions => {:gadget_id => obj.id, :gadget_type => obj.class.to_s, :widget => [Template::SLIDESHOW, Template::GALLERY]}).destroy
  end

  private
  
  def unique_image_display    
    if [Template::SLIDESHOW, Template::GALLERY].include? self.widget
      prev = Widget.find(:first, :conditions => {:gadget_id => self.gadget_id, :gadget_type => self.gadget_type, :widget => [Template::SLIDESHOW, Template::GALLERY]})
      prev.destroy unless prev.nil?
    end
  end
end
