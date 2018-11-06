class RequestController < ApplicationController
	layout false
	#def list
	#	requests = Request.all
	#	puts requests.inspect
	#	render :json => {:name => requests}
	#end

	def page_borrowed
	end

	def page_lended
	end

	def show
		render :json => {:status => nil}
	end

	def create
		render :json => {:status => nil}
	end

	def update
		render :json => {:status => nil}
	end

end
