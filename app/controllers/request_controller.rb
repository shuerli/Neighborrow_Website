class RequestController < ApplicationController
	layout false

	def page_borrowed
	end

	def page_lended
	end

	def show
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
					feedbacks_to_lender = ActiveRecord::Base.connection.exec_query(feedbacks_to_lender_query + order_query)
					feedbacks_to_borrower = ActiveRecord::Base.connection.exec_query(feedbacks_to_borrower_query + order_query)
					associated_lenders = ActiveRecord::Base.connection.exec_query(associated_lenders_query)
					associated_addresses = ActiveRecord::Base.connection.exec_query(associated_addresses_query)
					render :json => {:status => 200, :result => borrowed_requests, :feedbackToBorrower => feedbacks_to_borrower, :feedbackToLender => feedbacks_to_lender, :lenders => associated_lenders, :addresses => associated_addresses}
				end
			when 'keyword'
				requestid_search_query = "SELECT * FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND Requests.id = "+ params[:keyword].to_i
				itemid_search_query = "SELECT * FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND Items.id = "+ params[:keyword].to_i
				itemname_search_query = "SELECT * FROM Requests, Items WHERE Requests.borrower = 'geling.li@mail.utoronto.ca' AND Requests.item_id=Items.id AND Items.name = %"+ params[:keyword].to_i+"%"
				case params[:sorted_by]
				when 'update_time'
					order_query = " ORDER BY Requests.updated_at DESC;"


				when 'item_name'
					order_query = " ORDER BY Items.name ASC;"
					
					
				end
			end

		when'lended'
			case params[:sorted_by]
			when 'time'

			when 'itemName'

			when 'status'

			end
		else
			render :json => {:status => 404}
		end
		

	end

	def create
		
		render :json => {:status => nil}
	end

	def update

		render :json => {:status => nil}
	end



end
