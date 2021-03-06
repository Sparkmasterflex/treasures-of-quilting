class SubpagesController < ApplicationController
  before_filter :main_pages
  before_filter :require_user, :only => [:dashboard, :index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:dashboard, :index, :new, :edit, :update]
  before_filter :editor_layout, :only => [:dashboard, :index]

  def index

  end

  def new
    @subpage = Subpage.new
    render :layout => 'editor'
  end

  def create
    @subpage = Subpage.new(params[:subpage])

    if @subpage.save
      redirect_to webpages_path
    else
      editor_navigation
      render :layout => 'editor', :action => 'new'
    end
  end

  def show    
    @subpage = Subpage.find(:first, :conditions => {:page_alias => params[:page_alias]})
  end

  def edit
    @subpage = Subpage.find(params[:id])
    @images = @subpage.images.build
    render :layout => 'editor'
  end

  def update
    @subpage = Subpage.find(params[:id])
    @subpage.images.build(params[:images]) if params[:images]

    if @subpage.update_attributes(params[:subpage])
      flash[:success] = "#{@subpage.page_title} Has been successfully saved!"
    else
      editor_navigation
      flash[:error] = "We found the following errors."
    end
    render :action => :edit, :layout => 'editor'
  end
  
  def subpages_preview
    webpage = Webpage.find(params[:webpage_id].to_i)
    @subpages = webpage.subpages.paginate(:page => params[:page], :per_page => 4)
    respond_to do |format|
      format.html {}
      format.js { render :partial => '/subpages/subpage_preview', :locals => {:object => webpage, :subpages => @subpages} }
    end
  end

  def set_accessability
    subpage = Subpage.find(params[:sub].to_i)
    webpage = subpage.webpage
    enable = params[:enable] == "true"

    respond_to do |format|
      format.html {}
      format.js do
        subpage.update_attribute('enabled', enable)
        webpage.update_attribute('enabled', enable) if enable && !webpage.enabled
      end
    end
  end
end
