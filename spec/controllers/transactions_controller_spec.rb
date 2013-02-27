require 'spec_helper'

describe TransactionsController do
  let(:user) { FactoryGirl.create :user }
  let!(:transactions) do 
    (1..4).map { |n| FactoryGirl.create :transaction, user: user, date: n.days.from_now }
  end

  before { controller_sign_in user }

  describe 'GET #index' do
    before { get :index, user_id: user }

    it "builds a transaction for the user" do
      assigns(:transaction).user.should eq user
    end

    it "finds all transactions ordered by date" do
      assigns(:transactions).should eq transactions.sort_by(&:date).reverse
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new transaction" do
        expect do
          post :create, format: :js, transaction: FactoryGirl.attributes_for(:transaction)
        end.to change(Transaction, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't create a new transaction" do
        expect do
          post :create, format: :js, transaction: FactoryGirl.attributes_for(:invalid_transaction)
        end.to_not change(Transaction, :count)
      end
    end
  end

  context "with an existing transaction" do
    let!(:transaction) { FactoryGirl.create :transaction, user: user }

    describe 'GET #edit' do
      before do
        get :edit, id: transaction, format: :js
      end

      it "finds the transaction" do
        assigns(:transaction).should eq transaction
      end
    end

    describe 'PUT #update' do
      let(:new_amount)  { 1234.56 }
      before do
        put :update, format: :js, id: transaction, transaction: FactoryGirl.attributes_for(:transaction, amount: new_amount)
      end

      it "find the transaction" do
        assigns(:transaction).should eq transaction
      end

      it "updates the transaction" do
        Transaction.find(transaction.id).amount.should eq new_amount
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the transaction" do
        expect{ delete :destroy, id: transaction, format: :js }.to change(Transaction, :count).by(-1)
      end
    end
  end
end
