class PasswordResetsController < ApplicationController
  
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  
  def new
  end

  def get_user
      @account = Account.find_by(email: params[:email])
  end
  
  def valid_user
      unless (@account && @account.email_confirmed? &&
              @account.authenticated?(:reset, params[:id]))
              redirect_to home_url
      end
  end
  
  def create
       @account = Account.find_by(email: params[:password_reset][:email])
      if @account
          @account.create_reset_digest
          @account.send_password_reset_email
          flash[:info] = "Email sent with password reset instructions"
          redirect_to home_url
          else
          flash.now[:danger] = "Email address not found"
          render 'new'
      end
  end
  
  def edit
  end
end
