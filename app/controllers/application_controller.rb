class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  config.filter_parameters :password, :password_confirmation

  layout 'application'

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
