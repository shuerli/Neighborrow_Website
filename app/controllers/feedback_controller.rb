class FeedbackController < ApplicationController

	def create_toBorrower
		
	end

	def create_toLender

	end

	def show
		case params[:scope]
		when 'user'
		
		when 'feedback_to_lender'
		
		when 'feedback_to_borrower'
		
		end
	end

end
