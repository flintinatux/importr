class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update, :change_password]

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @saved = @user.save
      sign_in @user
      flash[:success] = "Welcome to importr, #{@user.name}!"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    if @updated = @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Your settings have been updated."
    end
    respond_to do |format|
      format.js
    end
  end

  def change_password
    if @updated = @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Your password has been changed."
    end
    respond_to do |format|
      format.js
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
