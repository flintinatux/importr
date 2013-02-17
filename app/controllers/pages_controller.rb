class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:dashboard]

  def home
    redirect_to dashboard_path if signed_in?
  end

  def dashboard
    @users = User.all
  end
end
