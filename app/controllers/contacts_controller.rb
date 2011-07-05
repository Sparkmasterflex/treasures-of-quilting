class ContactsController < ApplicationController
  def create
    Rails.logger.info "++++ params ++++"
    Rails.logger.info params.inspect
    Rails.logger.info "++++ params[:contact] ++++"
    Rails.logger.info params[:contact].inspect
    @contact = Contact.new(params[:contact])
    
    if @contact.save
      respond_to do |format|
        format.html {}
        format.js do
          render :partial => '/contacts/thankyou', :locals => {:contact => @contact }
        end
      end
    else
      respond_to do |format|
        format.html {}
        format.js do
          render :partial => '/contacts/form', :locals => { :contact => @contact }
        end
      end
    end
  end
end
