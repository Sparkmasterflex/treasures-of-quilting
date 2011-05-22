class ContactsController < ApplicationController
  def create
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
