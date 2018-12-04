class RequestController < ApplicationController
	layout false

	def page_borrowed
		if !current_user
			redirect_to "/login"
		end
	end

	def page_lended
		if !current_user
			redirect_to "/login"
		end
	end
    
    def complete
        @request = Request.find(params[:id])
        @item = Iten.find(@request.item_id)
    end
    
	def show
        if !current_user
            render :json => {:status => 403}
        end
        

		case params[:type]
		when 'borrowed'
			case params[:range]
			when 'all'
				user_email = Account.find_by(id: 1).email
				borrowed_requests_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Itens.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id"
				associated_lenders_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Itens.owner = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Requests.item_id = Itens.id AND Itens.address = Pickupaddresses.id AND Requests.borrower = '"+current_user.email+"';"
				case params[:sorted_by]
				when 'update_time'
					order_query = " ORDER BY Requests.updated_at DESC;"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(borrowed_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				when 'item_name'
					order_query = " ORDER BY Itens.name ASC;"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(borrowed_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				when 'request_id'
					order_query = " ORDER BY Requests.id ASC;"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(borrowed_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				end
			when 'keyword'
				if params[:keyword].match(/^(\d)+$/)!=nil
					search_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					associated_lenders_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Itens.owner = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Itens.address = Pickupaddresses.id AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Itens.id AND (Itens.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Itens.id AND (Itens.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Itens WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Itens.id AND (Itens.name LIKE '%"+params[:keyword]+"%');"
					associated_lenders_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Itens.owner = Profiles.email AND (Itens.name LIKE '%"+params[:keyword]+"%');"
					associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Itens.address = Pickupaddresses.id AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Itens.id AND (Itens.name LIKE '%"+params[:keyword]+"%');"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				end
				
			end

		when'lended'
			case params[:range]
			when 'all'
				#user_email = Account.find_by(id: 1).email
				lended_requests_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.item_id=Itens.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Itens, Feedback_to_lenders WHERE Itens.owner = '"+current_user.email+"' AND Requests.item_id=Itens.id AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Itens, Requests, feedback_to_borrowers WHERE Itens.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Itens.id"
				associated_borrower_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Itens.owner = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Requests.borrower = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Itens.address = Pickupaddresses.id AND Itens.owner = '"+current_user.email+"' AND Requests.item_id=Itens.id;"
				case params[:sorted_by]
				when 'update_time'
					order_query = " ORDER BY Requests.updated_at DESC;"
					lended_requests = ActiveRecord::Base.connection.exec_query(lended_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrower_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => lended_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_borrowers, :addresses => associated_addresses}
				when 'item_name'
					order_query = " ORDER BY Itens.name ASC;"
					lended_requests = ActiveRecord::Base.connection.exec_query(lended_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrower_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => lended_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_borrowers, :addresses => associated_addresses}
				when 'request_id'
					order_query = " ORDER BY Requests.id ASC;"
					lended_requests = ActiveRecord::Base.connection.exec_query(lended_requests_query + order_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrower_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => lended_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_borrowers, :addresses => associated_addresses}
				end
			when 'keyword'
				if params[:keyword].match(/^(\d)+$/)!=nil
					search_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					associated_borrowers_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Itens.owner = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Requests.borrower = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Itens.address = Pickupaddresses.id AND Itens.owner = '"+current_user.email+"' AND Requests.item_id = Itens.id AND (Requests.id = "+ params[:keyword] +" OR Itens.name LIKE '%"+params[:keyword]+"%' OR Itens.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrowers_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Itens.id AS \"item_id\", Itens.owner, Itens.name, Itens.photo_url FROM Requests, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.item_id=Itens.id AND Itens.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_lender_query = "SELECT Requests.id AS \"request_id\", Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Itens.id AND Itens.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_borrower_query = "SELECT Requests.id AS \"request_id\", feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Itens WHERE Itens.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Itens.id AND Itens.name LIKE '%"+params[:keyword]+"%';"
					associated_borrowers_query = "SELECT Accounts.id AS \"account_id\", Profiles.display_name, Requests.id AS \"request_id\", Profiles.email From Requests, Profiles, Itens, Accounts WHERE Accounts.email = Profiles.email AND Itens.owner = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Requests.borrower = Profiles.email AND Itens.name LIKE '%"+params[:keyword]+"%';"
					associated_addresses_query = "SELECT Requests.id AS \"request_id\", Pickupaddresses.* FROM Requests, Pickupaddresses, Itens WHERE Itens.address = Pickupaddresses.id AND Itens.owner = '"+current_user.email+"' AND Requests.item_id = Itens.id AND Itens.name LIKE '%"+params[:keyword]+"%';"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrowers_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_lenders, :addresses => associated_addresses}
				end
			end
		else
			render :json => {:status => 404}
		end
	end

	def create
		
        #Already checked inside the modal
        #if !current_user
        #	render :json => {:status => 403}
		#end
		

        item = Iten.find_by(id: params[:item_id])
        puts params.inspect
		@request = Request.new()
		@request.item_id = params[:item_id]
		@request.borrower = current_user.email
		#@request.address = params[:address]
		#@request.rejected_reason = params[:rejected_reason]
        @request.time_start = params[:time_start]
        @request.time_end = params[:time_end]
		

        
        #check if borrower rate is high enough
        #borrower rate = all feedback_to_borrowers where the requests have (borrower = current user)

        current_rating = ActiveRecord::Base.connection.exec_query("SELECT AVG(Feedback_to_borrowers.rate) AS \"rate\" FROM Feedback_to_borrowers, Requests, Accounts WHERE Accounts.id = #{current_user.id} AND Requests.borrower = Accounts.email AND Requests.id = Feedback_to_borrowers.request_id;");
		# Deposit check for item, if there's any
		current_credit = Pay.where(:email => current_user.email)
        puts (current_rating[0]["rate"])
        puts item.rate_level
        puts "!!!!!!!!!"
		puts "======================"
		puts current_rating[0]["rate"]
        #if (current_rating[0]["rate"]== nil or (current_rating[0]["rate"] < item.rate_level))
		#	puts "2"
        #    flash[:error] = "Sorry... Your rating is not high enough for this item."
        #    redirect_to :controller => "items" ,:action => "show", :id => params[:item_id]
		if(current_credit[current_credit.length-1]["credit"]==nil or current_credit[current_credit.length-1]["credit"]<item.deposit)

			flash[:error] = "Sorry... Your remaining credit is not high enough for the deposit of this item."
            redirect_to :controller => "items" ,:action => "show", :id => params[:item_id]
		elsif (Request.exists?(borrower: current_user.email, item_id: params[:item_id], status: "pending"))
            flash[:error] = "Cannot submit multiple requests for an item!"
            redirect_to :controller => "items" ,:action => "show", :id => params[:item_id]
		elsif(@request.save!)

			payment_create = Pay.new()
			payment_create.email = current_user.email
			payment_create.credit = current_credit[current_credit.length-1]["credit"] - item.deposit
			payment_create.save 
			################################### send email to lender ###################################
			query = "SELECT Itens.owner FROM Requests, Itens WHERE Requests.id = #{@request.id} AND Requests.item_id = Itens.id;"
			lender_email = ActiveRecord::Base.connection.exec_query(query)
			@account = Account.find_by(email: lender_email[0]["owner"])
			AccountMailer.status_update(@account).deliver
			###################################       END    ###################################
            redirect_to :action => "complete", :id => @request.id
		else
        #render :json => {:status => 500}
            redirect_to home_path
		end
	end
    
    private def request_params
        params.require(:request).permit(:item_id, :address, :rejected_reason)
    end

	def update
		if !current_user
			render :json => {:status => 403}
		end

		case params[:type]
		when 'accept'
			entry = Request.find(params[:id])
			entry.update( :status => 'accepted')
			##### email sent to borrower for status update ######
			##### need @account to be defined#####
			borrower_email = Request.find(params[:id]).borrower
			@account = Account.find_by(email: borrower_email)
            AccountMailer.status_update(@account).deliver

			##### end #####
			render :json => {:status => 200}
		when 'cancel'
			entry = Request.find(params[:id])
			entry.update( :status => 'cancelled')
			deposit = Iten.find(entry.item_id)["deposit"]
			payment_entry = Pay.where(:email => current_user.email)
			payment_entry.update( :credit => payment_entry[payment_entry.length-1]["credit"] + deposit)
			##### email sent to borrower for status update ######
			borrower_email = Request.find(params[:id]).borrower
			@account = Account.find_by(email: borrower_email)

			query = "SELECT Itens.owner FROM Requests, Itens WHERE Requests.id = #{params[:id]} AND Requests.item_id = Itens.id;"
			lender_email = ActiveRecord::Base.connection.exec_query(query)
			@account_sub = Account.find_by(email: lender_email[0]["owner"])

			AccountMailer.status_update(@account).deliver
			AccountMailer.status_update(@account_sub).deliver
			render :json => {:status => 200}
		when 'reject'
			entry = Request.find(params[:id])
			entry.update( :status => 'rejected', :rejected_reason => params[:reason])
			deposit = Iten.find(entry.item_id)["deposit"]
			payment_entry = Pay.where(:email => current_user.email)
			payment_entry.update( :credit => payment_entry[payment_entry.length-1]["credit"] + deposit)
			##### email sent to borrower for status update ######
			borrower_email = Request.find(params[:id]).borrower
			@account = Account.find_by(email: borrower_email)
            AccountMailer.status_update(@account).deliver
			render :json => {:status => 200}
		when 'complete'
			###################################################
			# Deposit Calculation and Payback
			puts "1"
			entry = Request.find(params[:id])
			deposit = Iten.find(entry.item_id)["deposit"]
			payment_entry_borrower = Pay.where(:email => current_user.email)
			payment_entry_borrower.update( :credit => payment_entry_borrower[payment_entry_borrower.length-1]["credit"] + (deposit))
			puts "2"
			payment_entry_lender = Pay.where(:email => Iten.find(entry.item_id)["owner"])
			payment_entry_lender.update( :credit => payment_entry_lender[payment_entry_lender.length-1]["credit"] + (deposit))
			###################################################
			puts "3"
			entry = Request.find(params[:id])
			entry.update( :returned => true, :status => 'completed')
			puts "4"
			render :json => {:status => 200}
		when 'receive'
			entry = Request.find(params[:id])
			entry.update( :received => true)
			render :json => {:status => 200}
		when 'return'
			entry = Request.find(params[:id])
			entry.update( :returned => true)
			
			render :json => {:status => 200}
		else
			render :json => {:status => 404}
		end
	end
end
