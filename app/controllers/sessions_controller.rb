class SessionsController < ApplicationController
  
  def login
      #respond_to do |format|
      #    format.html
      #    format.js
      #end
  end
  
  def create
      user = Account.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:email], params[:session][:password])
          if user.email_confirmed
              log_in user
              redirect_to home_url
          else
              flash.now[:error] = 'Please activate your account by following the instructions in the account confirmation email you received to proceed'
              render 'login'
          end
      else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'login'
      end
  end
  
  def create_auth
      user = Account.from_omniauth(request.env["omniauth.auth"])
      
      email = user.email
      profileparams = Hash.new
      profileparams[:email] = email
      username = email.split('@')
      profileparams[:display_name] = username[0]
      profileparams[:language] = "english"
      profileparams[:avatar_url] = "placeholder"  
      @profile = Profile.new(profileparams)        
      @profile.save
        
      log_in user
      redirect_to user
  end
  
  def destroy
      log_out
      redirect_to home_url
  end
end
