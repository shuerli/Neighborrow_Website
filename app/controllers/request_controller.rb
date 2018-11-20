class RequestController < ApplicationController
	layout false

	def page_borrowed
	end

	def page_lended
	end

	def show
		#puts "======Log-in as========"
		#puts current_user.email
		#puts "======Log-in as========"
		case params[:type]
		when 'borrowed'
			case params[:range]
			when 'all'
				user_email = Account.find_by(id: 1).email
				borrowed_requests_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id"
				associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Items.owner = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses WHERE Requests.address = Addresses.id AND Requests.borrower = 'geling.li@mail.utoronto.ca';"
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
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Items.owner = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
					associated_lenders_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Items.owner = Profiles.email AND (Items.name LIKE '%"+params[:keyword]+"%');"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND (Items.name LIKE '%"+params[:keyword]+"%');"
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
				user_email = Account.find_by(id: 1).email
				lended_requests_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id"
				feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Items, Feedback_to_lenders WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND Requests.id = Feedback_to_lenders.request_id"
				feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Items, Requests, feedback_to_borrowers WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id"
				associated_borrower_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email;"
				associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id;"
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
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_borrowers_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND (Requests.id = "+ params[:keyword] +" OR Items.name LIKE '%"+params[:keyword]+"%' OR Items.id = "+ params[:keyword] +");"
					borrowed_requests = ActiveRecord::Base.connection.exec_query(search_query)
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query)
					associated_borrowers = ActiveRecord::Base.connection.exec_query(associated_borrowers_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :borrowers => associated_lenders, :addresses => associated_addresses}
				else
					search_query = "SELECT Requests.*, Items.id AS item_id, Items.owner, Items.name, Items.photo_url FROM Requests, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_lender_query = "SELECT Requests.id AS request_id, Feedback_to_lenders.rate, Feedback_to_lenders.comment FROM Requests, Feedback_to_lenders, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_lenders.request_id AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					feedbacks_to_borrower_query = "SELECT Requests.id AS request_id, feedback_to_borrowers.rate, feedback_to_borrowers.comment FROM Requests, feedback_to_borrowers, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.id = Feedback_to_borrowers.request_id AND Requests.item_id=Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
					associated_borrowers_query = "SELECT Profiles.display_name, Requests.id AS request_id, Profiles.email From Requests, Profiles, Items WHERE Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Requests.borrower = Profiles.email AND Items.name LIKE '%"+params[:keyword]+"%';"
					associated_addresses_query = "SELECT Requests.id AS request_id, Addresses.* FROM Requests, Addresses, Items WHERE Requests.address = Addresses.id AND Items.owner = 'geling.li@mail.utoronto.ca' AND Requests.item_id = Items.id AND Items.name LIKE '%"+params[:keyword]+"%';"
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
		request = Request.new
		request.item_id = params[:item_id]
		request.borrower = params[current_user.email]
		request.address = params[:address]
		request.rejected_reason = params[:rejected_reason]
		request.time_start = params[:time_start]
		request.time_end = params[:time_end]
		if(request.save)
			render :json => {:status => 200}
		else
			render :json => {:status => 500}
		end
	end

	def update
		case params[:type]
		when 'accept'
			entry = Request.find(params[:id])
			entry.update( :status => 'accepted')
			render :json => {:status => 200}
		when 'cancel'
			entry = Request.find(params[:id])
			entry.update( :status => 'cancelled')
			render :json => {:status => 200}
		when 'reject'
			entry = Request.find(params[:id])
			entry.update( :status => 'rejected', :rejected_reason => params[:reason])
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
