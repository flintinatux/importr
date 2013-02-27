class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && @authenticated = user.authenticate(params[:password])
      sign_in user
    else
      flash.now[:error] = 'Invalid email/password combination.'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
