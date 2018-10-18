class SessionsController < ApplicationController
  
  def create
      auth_user = Account.authenticate(params[:session][:email], params[:session][:password])
    if auth_user
        #session[:userid] = auth_user.id
        redirect_to "http://localhost:3000/"
    else
        flash[:notice] = "Wrong password/email combination"
        render 'new'
    end
    
  end
  
  
  def new
  end
  
end
