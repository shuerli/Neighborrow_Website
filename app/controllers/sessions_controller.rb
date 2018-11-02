class SessionsController < ApplicationController
  
  def new
      respond_to do |format|
          format.html
          format.js
      end
  end
  
  def create
      user = Account.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:email], params[:session][:password])
          #log_in user
          redirect_to user
          else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
      end
  end
  
  def destroy
      log_out
      redirect_to root_url
  end
end
