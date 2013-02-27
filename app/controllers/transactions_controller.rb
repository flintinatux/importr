class TransactionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    redirect_to user_transactions_path(current_user) and return unless params[:user_id]
    @user = User.find(params[:user_id])
    @transaction = current_user.transactions.build
    @transactions = @user.transactions.paginate page: params[:page], per_page: per_page
  end

  def create
    @transaction = current_user.transactions.build params[:transaction]
    if @saved = @transaction.save
      flash[:success] = "New transaction ##{@transaction.id} created."
    end
  end

  def edit
  end

  def update
    if @updated = @transaction.update_attributes(params[:transaction])
      flash[:success] = "Transaction ##{@transaction.id} updated."
    end
  end

  def destroy
    @transaction.destroy
    flash[:success] = "Transaction ##{@transaction.id} has been deleted successfully."
    respond_to do |format|
      format.js
    end
  end

  private

    def per_page
      params[:per_page] || 50
    end
end
