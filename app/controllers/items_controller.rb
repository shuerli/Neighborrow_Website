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

		############################ User Check ##################################
		# Situation 1: Email
		# Situation 2: Display_name
		parameters = "display_name = '"+keyword+"' "
		email_check = (keyword =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
		if(email_check == 0)
			parameters = parameters + "OR email = '"+keyword+"';"
		end
		search_forUser = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE "+parameters)

		############################ Items Check ##################################
		# Situation 1: ISBN
		if(keyword.to_i.to_s == keyword && (keyword.length==13 || keyword.length==10))
			search_byISBN = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE isbn = '"+keyword.to_i+"'';")
		end

		# Situation 2: Id
		if(keyword.to_i.to_s == keyword)
			search_byItemID = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE id = "+keyword.to_i+";")
		end

		# Situation 3: Name & Brand
		search_byItemNameAndBrand = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE name LIKE '%"+keyword+"%' OR brand = '%"+keyword+"%';")
		
		render :json => {:status => 200, :result_user => search_forUser, :result_itemISBN => search_byISBN, :result_itemID => search_byItemID, :result_itemNameBrand => search_byItemNameAndBrand}
	end
end
