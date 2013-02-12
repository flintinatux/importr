include ApplicationHelper

def capybara_sign_in(user)
	visit signin_path
	fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def controller_sign_in(user)
  cookies[:remember_token] = user.remember_token
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers::define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', text: text)
  end
end