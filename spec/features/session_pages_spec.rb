require 'spec_helper'

describe "Authentication", js: true do

  # before  { visit root_path }
  # subject { page }

  # describe "signin page" do
  #   before { visit signin_path }

  #   it { should have_selector('h1', text: 'Sign in') }
  #   it { should have_title('Sign in') }
  # end

  # describe "signin" do
  #   before { visit signin_path }

  #   describe "with invalid information" do
  #     before { click_button "Sign in" }

  #     it { should have_title('Sign in') }
  #     it { should have_error_message('Invalid') }

  #     describe "after visiting another page" do
  #       before { click_link "Home" }
  #       it { should_not have_selector('div.alert.alert-error') }
  #     end
  #   end

  #   describe "with valid information" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     before { capybara_sign_in(user) }

  #     it { should have_link('Settings', href: edit_user_path(user)) }
  #     it { should have_link('Sign out', href: signout_path) }
      
  #     it { should_not have_link('Sign in', href: signin_path) }

  #     describe "followed by signout" do
  #       before { click_link "Sign out" }
  #       it { should have_link('Sign in') }
  #     end
  #   end
  # end

  # describe "authorization" do
    
  #   describe "for non-signed-in users" do
  #     let(:user) { FactoryGirl.create(:user) }

  #     describe "when attempting to visit a protected page" do
  #       before do
  #         visit edit_user_path(user)
  #         valid_signin(user)
  #       end

  #       describe "after signing in" do
          
  #         it "should render the desired protected page" do
  #           page.should have_title('Account settings')
  #         end
  #       end
  #     end

  #     describe "in the Users controller" do
        
  #       describe "visiting the edit page" do
  #         before { visit edit_user_path(user) }
  #         it { should have_title('Sign in') }
  #       end
  #     end
  #   end

  #   describe "as wrong user" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
  #     before { capybara_sign_in user }

  #     describe "visiting Users#edit page" do
  #       before { visit edit_user_path(wrong_user) }
  #       it { should_not have_title('Edit user') }
  #     end
  #   end
  # end
end
