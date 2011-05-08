class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  config.filter_parameters :password, :password_confirmation

  layout 'application'

  def enable(obj)
    @toggle = obj
    @object = obj.class == Image ? @toggle.attachable_type.constantize.find(@toggle.attachable_id) :
                                      @toggle.gadget_type.constantize.find(@toggle.gadget_id)
    enabled = params[:enable] == 'true'
    href = obj.class == Image ? '/images/slideshow_edit' : '/widgets/page_widgets'

    respond_to do |format|
      format.html {}
      format.js do
        @toggle.update_attribute('enabled', enabled)
        render :partial => href, :locals => {:object => @object}
      end
    end
  end

  def order(obj)
    @toggle = obj
    object = obj.is_a?(Image) ? @toggle.attachable_type.constantize.find(@toggle.attachable_id) :
                                  @toggle.gadget_type.constantize.find(@toggle.gadget_id)
    href = obj.is_a?(Image) ? '/images/slideshow_edit' : '/widgets/page_widgets'

    respond_to do |format|
      format.html {}
      format.js do
        @toggle.reorder(object, params[:sending].to_i)
        render :partial => href, :locals => {:object => object.reload}
      end
    end
  end

  private

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to login_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  # find main pages for sidebar navigation
  def main_pages
    @mainpages = Webpage.find(:all, :conditions => ['page_alias NOT IN (?) AND is_root != ? AND enabled = ?', ['about', 'contact'], true, true]);
  end

  def editor_navigation
    @webpages = Webpage.all
    @subpages = Subpage.all
    @images = Image.all
  end

  def editor_layout
    render :layout => 'editor'
  end
end
