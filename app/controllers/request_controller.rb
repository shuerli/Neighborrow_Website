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
        @item = Item.find(@request.item_id)
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
				borrowed_requests_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Items.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id"
				associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Items.id AND Items.owner = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses WHERE Requests.address = Addresses.id AND Requests.borrower = '"+current_user.email+"';"
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
					order_query = " ORDER BY Items.name ASC;"
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
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Items.id AND Items.owner = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Items.id AND Items.owner = Profiles.email AND (Items.name LIKE '%"+params[:keyword]+"%');"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Requests.borrower = '"+current_user.email+"' AND Requests.item_id = Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
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
				lended_requests_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id=Items.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Items, Feedback_to_lenders WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id=Items.id AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Items, Requests, feedback_to_borrowers WHERE Items.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id"
				associated_borrower_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = '"+current_user.email+"' AND Requests.item_id=Items.id;"
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
					order_query = " ORDER BY Items.name ASC;"
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
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_borrowers_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = '"+current_user.email+"' AND Requests.item_id = Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrowers_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					associated_borrowers_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = '"+current_user.email+"' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email AND Items.name LIKE '%"+params[:keyword]+"%';"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = '"+current_user.email+"' AND Requests.item_id = Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
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
        puts params.inspect
		@request = Request.new()
		@request.item_id = params[:item_id]
		@request.borrower = current_user.email
		@request.address = params[:address]
		@request.rejected_reason = params[:rejected_reason]
        @request.time_start = params[:time_start]
        @request.time_end = params[:time_end]
        
        if (Request.exists?(borrower: current_user.email, item_id: params[:item_id]))
            flash[:error] = "Cannot submit multiple requests for an item!"
            redirect_to :controller => "items" ,:action => "show", :id => params[:item_id]
		elsif(@request.save!)
			################################### send email to lender ###################################
			#lender_email = ActiveRecord::Base.connection.exec_query("SELECT Items.owner FROM Requests, Items WHERE Requests.id = "+params[:id]+" AND Requests.item_id = Items.id;")
			#@account = Account.find_by(email: lender_email[0]["owner"])
			#AccountMailer.status_update(@account).deliver
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
			##### email sent to borrower for status update ######
			borrower_email = Request.find(params[:id]).borrower
			@account = Account.find_by(email: borrower_email)

			#lender_email = ActiveRecord::Base.connection.exec_query("SELECT Items.owner FROM Requests, Items WHERE Requests.id = "+params[:id]+" AND Requests.item_id = Items.id;")
			#@account = Account.find_by(email: lender_email[0]["owner"])
			AccountMailer.status_update(@account).deliver
			render :json => {:status => 200}
		when 'reject'
			entry = Request.find(params[:id])
			entry.update( :status => 'rejected', :rejected_reason => params[:reason])
			##### email sent to borrower for status update ######
			borrower_email = Request.find(params[:id]).borrower
			@account = Account.find_by(email: borrower_email)
            AccountMailer.status_update(@account).deliver
			render :json => {:status => 200}
		when 'complete'
			entry = Request.find(params[:id])
			entry.update( :status => 'completed')
			render :json => {:status => 200}
		when 'receive'
			entry = Request.find(params[:id])
			entry.update( :received => true)
			render :json => {:status => 200}
		when 'return'
			entry = Request.find(params[:id])
			entry.update( :returned => false)
			render :json => {:status => 200}
		else
			render :json => {:status => 404}
		end
	end
end
