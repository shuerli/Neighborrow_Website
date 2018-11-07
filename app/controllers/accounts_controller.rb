require 'mail'
class AccountsController < ApplicationController
    
    def create
        #render plain: params[:account].inspect
        @account = Account.new(account_params)
        if (@account.save)
            log_in @account
            welcome_email @account
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
        @url = 'https://github.com/mikel/mail'

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
       
        #mail.delivery_method :sendmail
        mail.delivery_method :logger 
        mail.deliver
    end

end
