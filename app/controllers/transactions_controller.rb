class TransactionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    redirect_to user_transactions_path(current_user) and return unless params[:user_id]
    @user = User.find params[:user_id]
    build_new_transaction
    load_paginated_transactions
  end

  def create
    @transaction = current_user.transactions.build params[:transaction]
    if @transaction.save
      flash[:success] = "New transaction ##{transaction.id} created."
      build_new_transaction
      load_paginated_transactions
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def build_new_transaction
      @transaction = current_user.transactions.build
    end

    def load_paginated_transactions
      @transactions = @user.transactions.paginate page: params[:page], per_page: per_page
    end

    def per_page
      params[:per_page] || 50
    end
end
