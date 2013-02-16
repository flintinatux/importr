require 'spec_helper'

describe TransactionsController do
  let(:user) { FactoryGirl.create :user }
  let!(:transactions) do 
    (1..4).map { FactoryGirl.create :transaction, user: user }
  end

  before { controller_sign_in user }

  shared_examples 'it loads correct transactions' do
    it "builds a transaction for the user" do
      assigns(:transaction).user.should eq user
    end

    it "finds all transactions ordered by date" do
      assigns(:transactions)[0..3].should eq transactions.sort_by(&:date).reverse
    end
  end

  describe 'GET #index' do
    let!(:transactions) do 
      (1..4).map { FactoryGirl.create :transaction, user: user }
    end
    before { get :index, user_id: user }

    it_should_behave_like "it loads correct transactions" 
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new transaction" do
        expect do
          post :create, transaction: FactoryGirl.attributes_for(:transaction)
        end.to change(Transaction, :count).by(1)
      end

      before { post :create, transaction: FactoryGirl.attributes_for(:transaction, date: 20.days.ago) }
      it_should_behave_like "it loads correct transactions"
    end

    context "with invalid attributes" do
      it "doesn't create a new transaction" do
        expect do
          post :create, transaction: FactoryGirl.attributes_for(:invalid_transaction)
        end.to_not change(Transaction, :count)
      end
    end
  end

  describe "GET 'update'" do
    
  end

  describe "GET 'destroy'" do
    
  end

end
