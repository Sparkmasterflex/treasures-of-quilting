class ContactsController < ApplicationController
  before_filter :main_pages
  before_filter :require_user, :only => [:index, :edit, :update]
  before_filter :editor_navigation, :only => [:index, :show, :edit, :update]
  before_filter :get_contact, :only => [:show, :edit, :update]
  
  def index
    @contacts = Contact.all
    render :layout => 'editor'
  end
  
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
  
  def show
    render :layout => 'editor'
  end
  
  def edit
    render :layout => 'editor'
  end
  
  def update
    if @contact.update_attributes(params[:contact])
      flash[:success] = "Contact successfully updated"
      redirect_to contact_path(@contact)
    else
      render :action => :edit
    end
  end
  
  private
  
  def get_contact
    @contact = Contact.find(params[:id])
  end
end
