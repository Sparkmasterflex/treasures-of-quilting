class Contact < ActiveRecord::Base
  
  class Status
    NEW         =  0
    CONTACTED   = 10
    POTENTIAL   = 20
    CLIENT      = 30
    CLOSED      = 40
    
    LABELS = {NEW => 'New Contact', CONTACTED => 'Contacted', POTENTIAL => 'Potential Client', CLIENT => 'Current Client', CLOSED => 'Client Closed'}
  end
  
  validates :name, :email, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  
  private

  def send_email
    Notifier.contact_notification(self).deliver    
  end
end
