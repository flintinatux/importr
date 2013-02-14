class TransactionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :load_user
  before_filter :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @transaction = current_user.transactions.build
  end

  def show
  end

  def new
    @transaction = current_user.transactions.build
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def load_user
      @user = User.find params[:user_id]
    end
end
