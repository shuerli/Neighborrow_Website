require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class PaysController < ApplicationController
	layout false
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

        params.permit!
        paymentId = params[:paymentId]
        payerId =params[:PayerID]
        
        if @pay.add && paymentId
            if @pay.payid
                # Get payment ID from query string following redirect
                payment = Payment.find(paymentId)
                # Execute payment with the payer ID from query string following redirect
                if payment.execute(:payer_id => payerId)  #return true or false
                    flash.now[:success] = 'Credit Update Seccuessful'
                    logger.info "Payment[#{payment.id}] executed successfully"
                    params = Hash.new
                    params[:credit] = @pay.credit.to_i + @pay.add_credit.to_i
                    params[:add_credit] = nil
                    params[:payid] = nil
                    params[:add] = false
                    @pay.update(params)
                    else
                    logger.error payment.error.inspect
                end
            end
        end
       
    end
    
   
    
    def edit
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account[:email])
    end
    
    def editTwo
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account[:email])
    end
    
    def update
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account.email)
        
        @pay.update(pay_params)
        
        if @pay.add_credit
            # Build Payment object
            @payment = Payment.new({
                                   :intent =>  "sale",
                                   
                                   # ###Payer
                                   # A resource representing a Payer that funds a payment
                                   # Payment Method as 'paypal'
                                   :payer =>  {
                                   :payment_method =>  "paypal" },
                                   
                                   # ###Redirect URLs
                                   :redirect_urls => {
                                   :return_url => "https://neighborrow.herokuapp.com#{pay_path(@pay)}",
                                   :cancel_url => "https://neighborrow.herokuapp.com/Error" },
                                   
                                   # ###Transaction
                                   # A transaction defines the contract of a
                                   # payment - what is the payment for and who
                                   # is fulfilling it.
                                   :transactions =>  [{
                                   
                                   # ### Payee
                                   # Specify a payee with that user's email or merchant id
                                   # Merchant Id can be found at https://www.paypal.com/businessprofile/settings/
                                   :payee => {
                                   :email => "sixneighborrow-facilitator@gmail.com"
                                   },
                                   
                                   # Iten List
                                   :item_list => {
                                   :items => [{
                                   :name => "item",
                                   :sku => "item",
                                   :price => @pay.add_credit,
                                   :currency => "CAD",
                                   :quantity => 1 }]},
                                   
                                   # ###Amount
                                   # Let's you specify a payment amount.
                                   :amount =>  {
                                   :total => @pay.add_credit,
                                   :currency =>  "CAD" },
                                   :description =>  "This is the payment transaction description." }]})
                                   
                                   # Create Payment and return status
                                   if @payment.create
                                       # Redirect the user to given approval url
                                       @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
                                       params = Hash.new
                                       params[:payid] = @payment.id
                                       params[:add] = true
                                       @pay.update(params)
                                       redirect_to @redirect_url
                                   end
                                   
        elsif @pay.withdraw_credit
            if @pay.withdraw_credit > @pay.credit
                flash.now[:danger] = 'You cannot withdraw more amount than your current credit'
                render  'editTwo'
            else
                if @pay.update(pay_params)
                    params = Hash.new
                    params[:credit] = @pay.credit.to_i - @pay.withdraw_credit.to_i
                    params[:withdraw_credit] = nil
                    @pay.update(params)
                    flash.now[:success] = 'You have successfully submitted the request to withdraw your credit. Please allow 3-5 business days for us to process this transaction.'
                    render 'show'
                else
                    render 'editTwo'
                end
            end
        else
            render '/Error'
        end
        
    end
    
    private def pay_params
        params.require(:pay).permit(:email, :add_credit, :credit, :withdraw_credit)
    end
end
