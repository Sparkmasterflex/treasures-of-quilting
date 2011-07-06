class WebpagesController < ApplicationController
  before_filter :main_pages
  before_filter :require_user, :only => [:dashboard, :index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:dashboard, :index, :new, :edit, :update]
  before_filter :editor_layout, :only => [:index]

  def dashboard
    @contacts = Contact.find(:all, :conditions => {:status => Contact::Status::NEW}, :order => :created_at)
    render :layout => 'editor'
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
      render :layout => 'editor', :action => 'new'
    end
  end

  def show    
    @webpage = params[:page_alias] ? Webpage.find(:first, :conditions => {:page_alias => params[:page_alias]}) : Webpage.current_root
    @subpages = @webpage.subpages.paginate(:page => params[:page], :per_page => 4)
    @widgets = @webpage.widgets.for_page(true, 3)
    @contact = Contact.new if ['contact', 'treasures'].include?(@webpage.page_alias)
    @submitted = params[:submitted] || nil
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
    @webpage.widgets.build(params[:widgets]) if params[:widgets]

    if @webpage.update_attributes(params[:webpage])
      flash[:success] = "#{@webpage.page_title} Has been successfully saved!"
    else
      flash[:error] = "We found the following errors."
    end
    render :action => :edit, :layout => 'editor'
  end
  
  def calculate
    respond_to do |format|
      format.html {}
      format.js do
        if @values = Calculator.estimate(params)
          flash = "Congratulations! Estimate calculated!"
          render :partial => '/webpages/calculator/estimate', :locals => {:values => @values, :flash => flash}
        else
          flash = "Please provide all the necessary information."
          render :partial => '/webpages/calculator/form', :locals => {:params => params, :flash => flash}
        end
      end
    end
  end
  
  def send_estimate
    parameters = {:submitted => params[:calculated], :page_alias => 'contact'}
    redirect_to parameters.merge!(:action => :show)
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
