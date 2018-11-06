class RequestController < ApplicationController
	layout false

	def page_borrowed
	end

	def page_lended
	end

	def show
		case params[:type]
		when 'borrowed'
			case params[:sorted_by]
			when 'default'

			when 'update_time'
				user_email = Account.find_by(id: 1).email
				borrowed_requests = ActiveRecord::Base.connection.exec_query("SELECT * FROM Requests,Items WHERE Requests.borrower = 'activeuser@gmail.com' AND Requests.item_id=Items.id ORDER BY Requests.updated_at DESC;")
				render :json => {:status => 200, :result => borrowed_requests}
			when 'item_name'
				user_email = Account.find_by(id: 1).email
				borrowed_requests = ActiveRecord::Base.connection.exec_query("SELECT * FROM Requests,Items WHERE Requests.borrower = 'activeuser@gmail.com' AND Requests.item_id=Items.id ORDER BY Items.name ASC;")
				render :json => {:status => 200, :result => borrowed_requests}
			when 'lender_name'


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
