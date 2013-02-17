require 'spec_helper'

describe PagesController do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #home' do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    context "with signed-in user" do
      before do 
        controller_sign_in user
        get :home
      end

      it "redirects to dashboard" do
        response.should redirect_to dashboard_path
      end
    end
  end

  describe 'GET #dashboard' do
    
  end
end
