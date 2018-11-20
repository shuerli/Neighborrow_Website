require 'mail'
class AccountsController < ApplicationController
    
    def create
        #render plain: params[:account].inspect
        @account = Account.new(account_params)    
        
        email = account_params[:email]
        profileparams = Hash.new
        profileparams[:email] = email
        username = email.split('@')
        profileparams[:display_name] = username[0]
        profileparams[:language] = "english"
        profileparams[:avatar_url] = "placeholder"  
   
        @profile = Profile.new(profileparams)        
        
        if (@account.save and @profile.save)
            AccountMailer.registration_confirmation(@account).deliver
            flash[:notice] = "Sign up successful!"
            redirect_to @account
        else
            render 'new'
        end
    end
    
    def show
        @account = Account.find(params[:id])
    end
    
    def index
    end
    
    def new
        @account = Account.new
    end
    
    private def account_params
        params.require(:account).permit(:email, :password, :password_confirmation)
    end
    
    
    def welcome_email account

        #Set the url to be the home page
        @url = '/blank'

        #Reading the email body file as erb instead of plain text or html
        email_body = ERB.new(File.read('./app/views/mail_texts/welcome_email.html.erb')).result(binding)
        
        #Compose welcome_email
        mail = Mail.new do
            from    'zeyu.feng@mail.utoronto.ca'
            to      account.email
            subject 'Welcome to Neighborrow!'
            content_type 'text/html; charset=UTF-8'
            body    email_body
        end
       
        mail.delivery_method :sendmail
        #mail.delivery_method :logger
        mail.deliver
    end

    def confirm_email
        user = Account.find_by_confirm_token(params[:id])
        if user
            user.email_activate
            flash[:success] = "Welcome to the Neighborrow! Your email has been confirmed. Please sign in to continue."
            redirect_to '/login'
            else
            flash[:error] = "Sorry. User does not exist"
            redirect_to home_path
        end
    end
    
    def settings
        @account = Account.find_by(id: 1)
    end
    
end
