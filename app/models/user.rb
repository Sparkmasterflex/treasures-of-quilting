class User < ActiveRecord::Base
  acts_as_authentic

  class Roles
    DEFAULT      =  0
    MANAGER      = 10
    ADMIN        = 20
    SUPER_ADMIN  = 30

    LABELS = {DEFAULT => 'Viewer', MANAGER => 'Manager', ADMIN => 'Administrator', SUPER_ADMIN => 'Super Administrator'}

    def self.options_for_select
      LABELS.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end

  has_many :images, :as => :attachable

  attr_accessor :password
  attr_accessor :password_confirmation

  accepts_nested_attributes_for :images

  validates :first_name, :last_name, :role, :presence => true
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password, :password_confirmation, :presence => true, :length => { :within => 6..15 }


  def last_updated
    options = {:conditions => {:updated_by => self.id}, :order => :updated_at}
    array = [Webpage.find(:first, options), Subpage.find(:first, options)].reject { |m| m.nil? }
    array.sort!{|a, b| a.updated_at <=> b.updated_at } << "No pages updated by #{self.login}"
    array.first.is_a?(String) ? array.first : array.first.page_alias
  end
end
