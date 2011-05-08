class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:destroy]
  before_filter :editor_navigation, :only => :new

  def new
    @user_session = UserSession.new

    render :layout => 'login'
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Successfully logged in"
      redirect_to dashboard_path
    else
      flash[:error] = "Your username and password were incorrect."
      render :layout => 'login', :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "You are now logged out"
    redirect_to '/login'
  end
end
