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
        
        payparams = Hash.new
        payparams[:email] = email
        payparams[:credit] = '5'
        @pay = Pay.new(payparams)
        
        if (@account.save and @profile.save and @pay.save)
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
    
    def edit
      @account = Account.find(params[:id])
    end
    
    def update
      @account = Account.find(params[:id])
      if @account && @account.authenticate(@account.email, account_update_params[:old_password])
          if @account.update(account_params)
              flash[:success] = 'Password Updated!'
              redirect_to edit_account_path(@account.id)
          else
              flash[:danger] = 'Failed to Update Password!'
              render 'edit'
          end
      else
          flash[:danger] = 'Wrong Original Password!'
          render 'edit'
      end
        
        
        
    end
    
    private def account_update_params
        params.require(:account).permit(:old_password, :password, :password_confirmation)
    end
    
    
    def index
    end
    
    def new
        @account = Account.new
        #render layout: false
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
    
	def userSidebar_Info
		if !current_user
			render :json => {:status => 403}
		end
		display_name = ActiveRecord::Base.connection.exec_query("SELECT display_name FROM Profiles WHERE email = '"+current_user.email+"';")
		user_id = ActiveRecord::Base.connection.exec_query("SELECT id FROM Accounts WHERE email = '"+current_user.email+"';")
		@profile = Profile.find_by_email(current_user.email)

		borrower_rate = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_borrowers.rate) AS \"borrower_avg\" FROM Requests,Feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id;")
		borrower_credit = ActiveRecord::Base.connection.exec_query("SELECT SUM(Feedback_to_borrowers.credit) AS \"borrower_sum\" FROM Requests,Feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id;")
		lender_rate = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_lenders.rate) AS \"lender_avg\" FROM Requests, Itens, Feedback_to_lenders WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.id = Feedback_to_lenders.request_id;")
		lender_credit = ActiveRecord::Base.connection.exec_query("SELECT SUM(Feedback_to_lenders.credit) AS \"lender_sum\" FROM Requests, Itens, Feedback_to_lenders WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.id = Feedback_to_lenders.request_id;")
		render :json => {:status => 200, :id => user_id[0]["id"], :display_name => display_name[0]["display_name"], :display_photo => url_for(@profile.avatar), :borrower_rate => borrower_rate[0]["borrower_avg"], :borrower_credit => borrower_credit[0]["borrower_sum"], :lender_rate => lender_rate[0]["lender_avg"], :lender_credit => lender_credit[0]["lender_sum"]}
	end

	def userDashboard_Info
		if !current_user
			render :json => {:status => 403}
		end

		display_name = ActiveRecord::Base.connection.exec_query("SELECT display_name FROM Profiles WHERE email = '"+current_user.email+"';")

		borrower_rate = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_borrowers.rate) AS \"borrower_avg\" FROM Requests,Feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id;")
		borrower_credit = ActiveRecord::Base.connection.exec_query("SELECT SUM(Feedback_to_borrowers.credit) AS \"borrower_sum\" FROM Requests,Feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id;")
		lender_rate = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_lenders.rate) AS \"lender_avg\" FROM Requests, Itens, Feedback_to_lenders WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.id = Feedback_to_lenders.request_id;")
		lender_credit = ActiveRecord::Base.connection.exec_query("SELECT SUM(Feedback_to_lenders.credit) AS \"lender_sum\" FROM Requests, Itens, Feedback_to_lenders WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.id = Feedback_to_lenders.request_id;")

		lended_item_list = ActiveRecord::Base.connection.exec_query("SELECT Profiles.display_name AS \"borrowerName\", Requests.time_end AS \"endDate\", Itens.name AS \"itemName\" FROM Requests, Itens, Profiles WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.borrower = Profiles.email AND Requests.status = 'accepted' AND Requests.received = 'true' AND Requests.returned = 'false';")

		borrowed_item_list = ActiveRecord::Base.connection.exec_query("SELECT Profiles.display_name AS \"lenderName\", Requests.time_end AS \"endDate\", Itens.name AS \"itemName\" FROM Requests, Itens, Profiles WHERE Requests.borrower = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Itens.owner = Profiles.email AND Requests.status = 'accepted' AND Requests.received = 'true' AND Requests.returned = 'false';")
		
		pending_request_list = ActiveRecord::Base.connection.exec_query("SELECT Profiles.display_name AS \"borrowerName\", Requests.id AS \"requestID\", Requests.time_start AS \"startDate\", Requests.time_end AS \"endDate\", Itens.name AS \"itemName\" FROM Requests, Itens, Profiles WHERE Itens.owner = '"+current_user.email+"' AND Itens.id = Requests.item_id AND Requests.borrower = Profiles.email AND Requests.status = 'Pending';")

		render :json => {:status => 200, :display_name => display_name[0]["display_name"], :borrower_rate => borrower_rate[0]["borrower_avg"], :borrower_credit => borrower_credit[0]["borrower_sum"], :lender_rate => lender_rate[0]["lender_avg"], :lender_credit => lender_credit[0]["lender_sum"], :lended_item => lended_item_list, :pending_request => pending_request_list, :borrowed_item => borrowed_item_list}
	end
	

    def resendConfirmation
        render layout: false
        @account = Account.find(params[:id])
        AccountMailer.registration_confirmation(@account).deliver
    end
end
