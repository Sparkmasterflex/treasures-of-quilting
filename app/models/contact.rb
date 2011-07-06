class Contact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  class Status
    NEW         =  0
    CONTACTED   = 10
    POTENTIAL   = 20
    CLIENT      = 30
    CLOSED      = 40
    
    LABELS = { NEW => 'New Contact', CONTACTED => 'Contacted', POTENTIAL => 'Potential Client', CLIENT => 'Current Client', CLOSED => 'Client Closed' }
  end
  
  attr_accessor :estimate
  
  before_save :append_estimate
  after_save :send_email
  
  validates :name, :email, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  
  def to_hash(str)
    unless str.blank?
      attributes = []
      str.gsub!(/^value\{/, '').gsub!(/\}$/, '')
      
      str.split(',').each do |sub|
        arr = sub.strip.split('=>')
        if arr.first =~ /^:sq_inches/
          attributes << "Dimensions (sq inches): #{arr.last}"
        else
          attributes << "#{arr.first.gsub(/\:/, '').capitalize}: #{number_to_currency(arr.last)}"
        end
      end
      
      attributes
    end
  end
  
  private

  def send_email
    ContactMailer.contact_notification(self).deliver
  end
  
  def append_estimate
    unless @estimate.blank?
      self.message.blank? ? self.message = to_hash(@estimate) :
                              self.message += '<br /><br />Begin estimate:<br />---------------------------<br />' + to_hash(@estimate) * '<br />'
    end
  end
end
