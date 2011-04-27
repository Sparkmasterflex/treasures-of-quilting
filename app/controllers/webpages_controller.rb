class WebpagesController < ApplicationController
  before_filter :main_pages
  before_filter :require_user, :only => [:dashboard, :index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:dashboard, :index, :new, :edit, :update]
  before_filter :editor_layout, :only => [:dashboard, :index]

  def dashboard

  end

  def index

  end

  def new
    @webpage = Webpage.new
    render :layout => 'editor'
  end

  def create
    @webpage = Webpage.new(params[:webpage])

    if @webpage.save
      redirect_to webpages_path
    else
      render :action => 'new'
    end
  end

  def show    
    @webpage = params[:page_alias] ? Webpage.find(:first, :conditions => {:page_alias => params[:page_alias]}) : Webpage.current_root
    @subpages = @webpage.subpages.paginate(:page => params[:page], :per_page => 4)
    @contact = Contact.new
  end

  def edit
    @webpage = Webpage.find(params[:id])
    @subpages = @webpage.subpages.build
    @images = @webpage.images.build
    render :layout => 'editor'
  end

  def update
    @webpage = Webpage.find(params[:id])
    @webpage.images.build(params[:images]) if params[:images]

    if @webpage.update_attributes(params[:webpage])
      flash[:success] = "#{@webpage.page_title} Has been successfully saved!"
    else
      flash[:error] = "We found the following errors."
    end
    render :action => :edit, :layout => 'editor'
  end

  def set_accessability
    webpage = Webpage.find(params[:web].to_i)
    subpages = webpage.subpages
    enable = params[:enable] == "true"

    respond_to do |format|
      format.html {}
      format.js do
        webpage.update_attribute('enabled', enable)
        subpages.each { |sub| sub.update_attribute('enabled', enable) } unless enable
      end
    end
  end
end
