class AccountsController < ApplicationController
    
    def create
        #render plain: params[:account].inspect
        @account = Account.new(account_params)
        if (@account.save)
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
        require 'mail'

        #Set the url to be the home page
        @url = 'https://github.com/mikel/mail'

        mail = Mail.new do
            from    'zeyu.feng@mail.utoronto.ca'
            to      account.email
            subject 'Welcome to Neighborrow!'
            body    File.read('./app/views/mail_texts/welcome_email.text.erb')
        end
       
        mail.delivery_method :logger
        mail.deliver
    end

end
