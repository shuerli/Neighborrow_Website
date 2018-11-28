class PasswordResetsController < ApplicationController
  
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
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
          flash.now[:info] = "An email has been sent with password reset instructions"
          render 'new'
          else
          flash.now[:danger] = "Email address not found"
          render 'new'
      end
  end
  
  def edit
  end
  
  def update
      if params[:account][:password].empty?
          @account.errors.add(:password, "can't be empty")
          render 'edit'
      elsif @account.update_attributes(account_params)
          flash[:success] = "Your password has been reset. Please enter your email and password to log in now!"
          redirect_to '/login'
      else
          render 'edit'
      end
  end
  
  def check_expiration
      if @account.password_reset_expired?
          flash[:danger] = "Password reset has expired."
          redirect_to new_password_reset_url
      end
  end
  
  private
  
  def account_params
      params.require(:account).permit(:password, :password_confirmation)
  end
end
