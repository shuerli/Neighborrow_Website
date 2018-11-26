class ItemsController < ApplicationController
    def new
    end
    def edit
    end
    def create
    end
    def update
    end
    
    def destroy
        @item = Items.find(params[])
        @item.update(params.require(:item).permit(:status))
	end
	
	def keyword_prompt
		search_result = ActiveRecord::Base.connection.exec_query("SELECT name FROM Items WHERE name LIKE '"+params[:input]+"%' ")
		render :json => {:status => 200, :result => search_result}
	end

	def showResult
	end

	def generateResult
		keyword = params[:keyword]
		location = params[:location]
		# Consider about two cases
		# Case 1: Keyword of Items (id, name, brand, 10-digit or 13-digit isbn)
		# Case 2: Keyword of Users (display_name, email)
		# Case 3: Keyword of Locations (current_city)

		#require 'gingerice'
		#text = 'textbeek'
		#parser = Gingerice::Parser.new
		#result = parser.parse text
		#puts result["result"]

		# Items Check
		# Situation 1: ISBN
		# Situation 2: Id
		# Situation 3: Name & Brand

		# User Check
		# Situation 1: Email
		# Situation 2: Display_name

	end
end
