class ContactMailer < ActionMailer::Base
  default :from => "no-reply@treasuresofquilting.com"

  def contact_notification(sender)
    @sender = sender
    mail(:to => "raymondke99@gmail.com",
         :from => sender.email,
         :subject => "New Contact from #{sender.name}")
  end
end
