class AccountsController < ApplicationController
    
    def create
        #render plain: params[:account].inspect
        @account = Account.new(account_params)
        if (@account.save)
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
    
end
