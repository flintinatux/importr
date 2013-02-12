require 'spec_helper'

describe UsersController do

  describe 'GET #new' do
    before :each do
      get :new
    end

    it "builds a new instance of User" do
      assigns(:user).should be_instance_of(User)
    end
  end

  let(:name)     { 'John Smith' }
  let(:email)    { 'john@smith.com' }
  let(:password) { 'foobar' }
    
  describe 'POST #create' do
    before :each do
      post :create, user: { name: name, email: email, password: password, password_confirmation: password }
    end

    it "creates a new user" do
      user = User.find_by_email(email)
      user.name.should eq name
    end

    it "redirects to root path" do
      response.should redirect_to(root_path)
    end
  end

  context 'with an existing user' do
    let(:user) do 
      FactoryGirl.create :user, name: name, email: email, password: password, password_confirmation: password
    end

    context "who is signed in" do
      before { controller_sign_in user }

      describe 'GET #edit' do
        before :each do
          get :edit, id: user.id
        end

        it "returns the requested user to edit" do
          assigns(:user).should eq user
        end
      end

      describe 'PUT #update' do
        let(:new_name) { 'Jane Doe' }
        before :each do
          put :update, id: user.id, user: { name: new_name, email: email, 
                                            password: password, password_confirmation: password }
        end

        it "updates the user" do
          user = User.find_by_email(email)
          user.name.should eq new_name
        end
      end
    end
  end
end
