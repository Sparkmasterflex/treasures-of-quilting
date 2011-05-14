class UsersController < ApplicationController
  before_filter :require_user
  before_filter :editor_navigation

  def new
    @user = User.new
    @user.images.build
    editor_layout
  end

  def create
    @user = User.new(params[:user])
    @user.images.build(params[:images]) if params[:images]
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default user_url
    else
      editor_layout(:new)
    end
  end

  def show
    @user = User.find(params[:id])
    editor_layout
  end

  def edit
    @user = User.find(params[:id])
    @user.images.build if @user.images.blank?
    editor_layout
  end

  def update
    @user = @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url
    else
      editor_layout(:edit)
    end
  end
end
