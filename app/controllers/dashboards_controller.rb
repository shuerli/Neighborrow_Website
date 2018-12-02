class DashboardsController < ApplicationController
	layout false
	def admin
	end

	def user
		if !current_user
			redirect_to "/login"
		end
	end

	def show_report
	end
end
