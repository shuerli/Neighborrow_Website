require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

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

        params.permit!
        paymentId = params[:paymentId]
        payerId =params[:PayerID]
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
                @pay.update(params)
             else
                logger.error payment.error.inspect
           
            end
        end
        #params = Hash.new
        #params[:credit] = @pay.credit.to_i + @pay.add_credit.to_i
        #params[:add_credit] = nil
        #@pay.update(params)
    end
    
    #   def showPay
        # Get payment ID from query string following redirect
        #   payment = Payment.find(ENV["PAYMENT_ID"])
        #@account = Account.find(current_user.id)
        #@pay = Pay.find_by_email(@account.email)

        # Execute payment with the payer ID from query string following redirect
        #if payment.execute( :payer_id => ENV["PAYER_ID"] )  #return true or false
        #   logger.info "Payment[#{payment.id}] executed successfully"
        #   else
        #   logger.error payment.error.inspect
        #end
        #end
    
    def edit
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account[:email])
    end
    
    def update
        @account = Account.find(current_user.id)
        @pay = Pay.find_by_email(@account.email)
        
        if @pay.update(pay_params)
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
                                   :return_url => "http://localhost:3000#{pay_path(@pay)}",
                                   :cancel_url => "http://localhost:3000/Error" },
                                   
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
                                   
                                   # Item List
                                   :item_list => {
                                   :items => [{
                                   :name => "item",
                                   :sku => "item",
                                   :price => "5",
                                   :currency => "CAD",
                                   :quantity => 1 }]},
                                   
                                   # ###Amount
                                   # Let's you specify a payment amount.
                                   :amount =>  {
                                   :total =>  "5",
                                   :currency =>  "CAD" },
                                   :description =>  "This is the payment transaction description." }]})
                                   
                                   # Create Payment and return status
                                   if @payment.create
                                       # Redirect the user to given approval url
                                       @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
                                       params = Hash.new
                                       params[:payid] = @payment.id
                                       @pay.update(params)
                                       redirect_to @redirect_url
                                       else
                                       logger.error @payment.error.inspect
                                   end
        else
            render 'edit'
        end
        
    end
    
    def execute
        # ID of the payment. This ID is provided when creating payment.
        payment_id = ENV["PAYMENT_ID"] || "PAY-83Y70608H1071210EKES5UNA"
        @payment = Payment.find(payment_id)
        
        # PayerID is required to approve the payment.
        if @payment.execute( :payer_id => ENV["PAYER_ID"] || "DUFRQ8GWYMJXC" )  # return true or false
            logger.info "Payment[#{@payment.id}] execute successfully"
            else
            logger.error @payment.error.inspect
        end
    end
    
    private def pay_params
        params.require(:pay).permit(:email, :add_credit, :credit, :withdraw_credit)
    end
end
