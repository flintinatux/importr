require 'spec_helper'

describe TransactionsController do
  let(:user) { FactoryGirl.create :user }
  let(:transactions) do 
    (1..4).map { FactoryGirl.create :transaction, user: user }
  end

  before { controller_sign_in user }

  describe 'GET #index' do
    let!(:transactions) do 
      (1..4).map { FactoryGirl.create :transaction, user: user }
    end
    before { get :index, user_id: user }

    it "builds a transaction for the user" do
      assigns(:transaction).user.should eq user
    end

    it "finds all transactions ordered by date" do
      assigns(:transactions).should eq transactions.reverse
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new transaction" do
        expect do
          post :create, user_id: user, transaction: FactoryGirl.attributes_for(:transaction)
        end.to change(Transaction, :count).by(1)
      end
      
      it "redirects to the transaction list" do
        post :create, user_id: user, transaction: FactoryGirl.attributes_for(:transaction)
        response.should redirect_to user_transactions_path(user)
      end
    end

    context "with invalid attributes" do
      it "doesn't create a new transaction" do
        expect do
          post :create, user_id: user, transaction: FactoryGirl.attributes_for(:invalid_transaction)
        end.to_not change(Transaction, :count)
      end

      it "re-renders the index template" do
        post :create, user_id: user, transaction: FactoryGirl.attributes_for(:invalid_transaction)
        response.should render_template :index
      end
    end
  end

  describe "GET 'edit'" do
    
  end

  describe "GET 'update'" do
    
  end

  describe "GET 'destroy'" do
    
  end

end
