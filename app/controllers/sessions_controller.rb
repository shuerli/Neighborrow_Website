class SessionsController < ApplicationController
  
  def login
      #respond_to do |format|
      #    format.html
      #    format.js
      #end
  end
  
  def create
      user = Account.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:email], params[:session][:password])
          log_in user
          redirect_to user
    else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'login'
      end
  end
  
  def destroy
      log_out
      redirect_to home_url
  end
end
