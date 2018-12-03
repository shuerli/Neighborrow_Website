class ReportsController < ApplicationController
	layout false
	def index
		if !current_user
			redirect_to "/login"
		end
	end
	
	def create
		if !current_user
            render :json => {:status => 403}
        end
		report = Report.new
		report.report_type = params[:report_type]
		report.subject = params[:subject]
		report.content = params[:content]
		report.status = "submitted"
		report.time_submitted = params["time_submitted"]
		report.time_closed = ""
		report.request_id = params[:request_id]
		report.save
		render :json => {:status => 200}
	end
end
