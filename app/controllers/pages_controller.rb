class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:dashboard]

  def home
    redirect_to dashboard_path if signed_in?
  end

  def dashboard
    @game_end = Date.new(2013, 6, 30)
    @users = User.all.sort_by(&:net_income).reverse
    @transactions = Transaction.limit(10)
  end
end
