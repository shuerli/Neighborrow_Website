class PaymentsController < ApplicationController
    def new
        @payment = Payment.new
    end
    
    def create
        @payment = Payment.new(payment_params)
        @payment.save
    end
    
    def show
        @account = Account.find(current_user.id)
        @payment = Payment.find_by_email(@account.email)         
    end
    
    def edit
        @account = Account.find(current_user.id)
        @payment = Payment.find_by_email(@account[:email])
    end
    
    def update
        @account = Account.find(current_user.id)
        @payment = Payment.find_by_email(@account.email)
        
        if @payment.update(payment_params)
            redirect_to @payment.paypal_url(payment_path(@payment))
        else
            render 'edit'
        end
        
    end
    
    private def payment_params
        params.require(:payment).permit(:email, :add_credit, :credit, :withdraw_credit)
    end
end
