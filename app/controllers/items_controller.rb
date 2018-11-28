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
			search_byUserEmail = ActiveRecord::Base.connection.exec_query("SELECT id, display_name, gender, language, country, avatar_url FROM Accounts, Profiles WHERE Accounts.email = Profiles.email AND Profiles.email = '"+keyword+"' AND Accounts.role <> 'Admin';")
			search_byUserEmail_borrowRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_borrowers.rate) AS borrow_rate FROM feedback_to_borrowers, requests WHERE requests.borrower = '"+keyword+"' AND feedback_to_borrowers.request_id = requests.id;")
			search_byUserEmail_lendRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_lenders.rate) AS lend_rate FROM feedback_to_lenders, requests, items WHERE items.owner = '"+keyword+"' AND feedback_to_lenders.request_id = requests.id AND requests.item_id = items.id;")
		end
		#search_byUserName = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE display_name = '"+keyword+"';")
		############################ Items Check ##################################
		# Situation 1: ISBN
		if(keyword.to_i.to_s == keyword && (keyword.length==13 || keyword.length==10))
			search_byISBN = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Items.owner = Profiles.email AND Items.isbn = '"+keyword.to_i+"'';")
		end

		# Situation 2: Id (Abandoned)
		#if(keyword.to_i.to_s == keyword)
		#	search_byItemID = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Items.owner = Profiles.email AND Items.id = "+keyword.to_i+";")
		#end

		# Situation 3: Name & Brand
		search_byItemNameAndBrand = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Items.owner = Profiles.email AND (LOWER(Items.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Items.brand) = LOWER('%"+keyword+"%'));")
		if(:search_byItemNameAndBrand.size==0)
			require 'gingerice'
			parser = Gingerice::Parser.new
			correction = parser.parse(keyword)
			correction_result = correction["result"].downcase
			search_byCorrection = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Items.owner = Profiles.email AND (LOWER(Items.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Items.brand) = LOWER('%"+correction_result+"%'));")
		end
		
		render :json => {:status => 200, :search_keyword => keyword, :result_userEmail => {result: search_byUserEmail, borrowRate: search_byUserEmail_borrowRate, lendRate: search_byUserEmail_lendRate}, :result_itemISBN => search_byISBN, :result_itemNameBrand => search_byItemNameAndBrand, :corrected_keyword => correction_result, :result_correctedKeyword => search_byCorrection}
	end
end
