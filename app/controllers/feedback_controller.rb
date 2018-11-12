class FeedbackController < ApplicationController

	def show
		case params[:scope]
		when 'user'
			as_lender_query = "SELECT Feedback_to_lenders.* FROM Feedback_to_lenders, Requests, Items WHERE Feedback_to_lenders.request_id = Requests.id AND Requests.item_id = Items.id AND Items.owner = '';" 
			as_borrower_query = "SELECT Feedback_to_borrowers.* FROM Feedback_to_borrowers, Requests WHERE Requests.borrower = '' AND Requests.id = Feedback_to_borrowers.request_id;"
			as_lender_rate_query = "SELECT AVG(Feedback_to_lenders.rate) FROM Feedback_to_lenders, Requests, Items WHERE Feedback_to_lenders.request_id = Requests.id AND Requests.item_id = Items.id AND Items.owner = '';";
			as_borrower_rate_query = "SELECT AVG(Feedback_to_borrowers.rate) FROM Feedback_to_borrowers, Requests WHERE Requests.borrower = '' AND Requests.id = Feedback_to_borrowers.request_id;";
			feedback_to_lender_list = ActiveRecord::Base.connection.exec_query(as_lender_query)
			feedback_to_borrower_list = ActiveRecord::Base.connection.exec_query(as_borrower_query)
			as_lender_rate = ActiveRecord::Base.connection.exec_query(as_lender_rate_query)
			as_borrower_rate = ActiveRecord::Base.connection.exec_query(as_borrower_rate_query)
			render :json => {:status => 200, :as_lender => feedback_to_lender_list, :as_borrower => feedback_to_borrower_list, :rate_as_lender => as_lender_rate, :rate_as_borrower => as_borrower_rate}
		when 'items'
		else
			render :json => {:status => 404}
		end
	end

	def create_toLender
		entry = FeedbackToLender.new
		entry.request_id = params[:request_id]
		entry.rate = params[:rate].to_i
		entry.comment = params[:comment]
		entry.credit = 5
		entry.save 
	end

	def create_toBorrower
		entry = FeedbackToLender.new
		entry.request_id = params[:request_id]
		entry.rate = params[:rate].to_i
		entry.comment = params[:comment]
		entry.credit = 5
		entry.save 
	end

end
