class ItemsController < ApplicationController
    def new
    end
    def edit
    end
    def create
    end
    def update
    end
    
    def show
        @item = Item.find(params[:id])
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

		############################ User Check ##################################
		# Situation 1: Email
		# Situation 2: Display_name
		email_check = (keyword =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
		if(email_check == 0)
			search_byUserEmail = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE email = '"+keyword+"';")
		end
		search_byUserName = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE display_name = '"+keyword+"';")
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
		search_byItemNameAndBrand = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE LOWER(name) LIKE LOWER('%"+keyword+"%') OR LOWER(brand) = LOWER('%"+keyword+"%');")
		puts :search_byItemNameAndBrand.size
		if(0)
			require 'gingerice'
			parser = Gingerice::Parser.new
			correction = parser.parse(keyword)
			correction_result = correction["result"].downcase
			search_byCorrection = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE LOWER(name) LIKE LOWER('%"+correction_result+"%') OR LOWER(brand) = LOWER('%"+correction_result+"%');")
		end
		
		render :json => {:status => 200, :result_userEmail => search_byUserEmail, :result_userName => search_byUserName, :result_itemISBN => search_byISBN, :result_itemID => search_byItemID, :result_itemNameBrand => search_byItemNameAndBrand, :corrected_keyword => correction_result, :result_correctedKeyword => search_byCorrection}
	end
end
