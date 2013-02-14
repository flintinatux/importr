require 'spec_helper'

describe TransactionsController do
  let(:user) { FactoryGirl.create :user }
  before { controller_sign_in user }

  describe "GET 'index'" do
    
  end

  describe "GET 'show'" do
    
  end

  describe 'GET #new' do
    before { get :new, user_id: user }

    it "builds a transaction for the user" do
      assigns(:transaction).user.should eq user
    end
  end

  describe "GET 'create'" do
    
  end

  describe "GET 'edit'" do
    
  end

  describe "GET 'update'" do
    
  end

  describe "GET 'destroy'" do
    
  end

end
