class PaysController < ApplicationController
    def new
        @pay = Pay.new
    end
    
    def create
        @pay = Pay.new(pay_params)
        @pay.save
    end
    
    def show
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account.email)
        
        params = Hash.new
        params[:credit] = @pay.credit.to_i + @pay.add_credit.to_i
        params[:add_credit] = nil
        @pay.update(params)
    end
    
    def edit
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account[:email])
    end
    
    def update
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account.email)
        
        if @pay.update(pay_params)
            redirect_to @pay.paypal_url(pay_path(@pay))
        else
            render 'edit'
        end
        
    end
    
    private def pay_params
        params.require(:pay).permit(:email, :add_credit, :credit, :withdraw_credit)
    end
end
