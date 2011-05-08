class UsersController < ApplicationController
  before_filter :require_user
  before_filter :editor_navigation

  def new
    @new_user = User.new
    @new_user.images.build
    editor_layout
  end

  def create
    @new_user = User.new(params[:user])
    @new_user.images.build(params[:images]) if params[:images]
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      editor_layout(:new)
    end
  end

  def show
    @user = @current_user
    editor_layout
  end

  def edit
    @user = User.find(params[:id])
    @user.images.build if @user.images.blank?
    editor_layout
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      editor_layout(:edit)
    end
  end
end
