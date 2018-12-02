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
    
    def index
        @item_ids = []
        @categories = Category.where(:department => params[:department])
        @categories.each do |cat|
            puts cat.id
            @item_ids << Item.where(:category_id => cat.id).map(&:id)
        end
        

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
		city = "Toronto"
		province = "Ontario"
		country = "Canada"
		if(params[:city] != "undefined" && params[:province] != "undefined" && params[:country] != "undefined")
			city = params[:city]
			province = params[:province]
			country = params[:country]
		end

		
		# Consider about two cases
		# Case 1: Keyword of Items (id, name, brand, 10-digit or 13-digit isbn)
		# Case 2: Keyword of Users (display_name, email)
		# Case 3: Keyword of Locations (current_city)

		############################ User Check ##################################
		# Situation 1: Email
		# Situation 2: Display_name
		email_check = (keyword =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
		user_avatar = nil
		if(email_check == 0)
			search_byUserEmail = ActiveRecord::Base.connection.exec_query("SELECT Accounts.id, display_name, gender, language, country, avatar_url FROM Accounts, Profiles WHERE Accounts.email = Profiles.email AND Profiles.email = '"+keyword+"';")
			search_byUserEmail_borrowRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_borrowers.rate) AS borrow_rate FROM feedback_to_borrowers, requests WHERE requests.borrower = '"+keyword+"' AND feedback_to_borrowers.request_id = requests.id;")
			search_byUserEmail_lendRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_lenders.rate) AS lend_rate FROM feedback_to_lenders, requests, items WHERE items.owner = '"+keyword+"' AND feedback_to_lenders.request_id = requests.id AND requests.item_id = items.id;")
			@profile = Profile.find_by_email(keyword)
			if(@profile)
				user_avatar = url_for(@profile.avatar)
			end
		end
		#search_byUserName = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE display_name = '"+keyword+"';")
		############################ Items Check ##################################
		# Situation 1: ISBN
		if(keyword.to_i.to_s == keyword && (keyword.length==13 || keyword.length==10))
			search_byISBN = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Items.owner = Profiles.email AND Items.isbn = '"+keyword.to_i+"';")
			search_byISBN_history = ActiveRecord::Base.connection.exec_query("SELECT Items.id AS itemID, COUNT(*) AS count FROM Requests, Items, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Requests.item_id = Items.id AND Items.isbn = '"+keyword.to_i+"' GROUP BY Items.id;")
		end

		# Situation 2: Id (Abandoned)
		#if(keyword.to_i.to_s == keyword)
		#	search_byItemID = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Items.owner = Profiles.email AND Items.id = "+keyword.to_i+";")
		#end

		# Situation 3: Name & Brand
		search_byItemNameAndBrand = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Items.owner = Profiles.email AND (LOWER(Items.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Items.brand) = LOWER('%"+keyword+"%'));")
		search_byItemNameAndBrand_history = ActiveRecord::Base.connection.exec_query("SELECT Items.id AS itemID, COUNT(*) AS count FROM Requests, Items, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Requests.item_id = Items.id AND (LOWER(Items.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Items.brand) = LOWER('%"+keyword+"%')) GROUP BY Items.id;")
		if(:search_byItemNameAndBrand.size==0)
			require 'gingerice'
			parser = Gingerice::Parser.new
			correction = parser.parse(keyword)
			correction_result = correction["result"].downcase
			search_byCorrection = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Items.condition AS itemCondition, Items.id AS itemID, Items.name, Items.rate_level AS minRate, Items.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Items, Profiles, Accounts, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Items.owner = Profiles.email AND (LOWER(Items.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Items.brand) = LOWER('%"+correction_result+"%'));")
			search_byCorrection_history = ActiveRecord::Base.connection.exec_query("SELECT Items.id AS itemID, COUNT(*) AS count FROM Requests, Items, Addresses WHERE Items.address = Addresses.id AND Addresses.city = '"+city+"' AND Addresses.province = '"+province+"' AND Addresses.country = '"+country+"' AND Requests.item_id = Items.id AND (LOWER(Items.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Items.brand) = LOWER('%"+correction_result+"%')) GROUP BY Items.id;")
		end
		
		render :json => {:status => 200, :given_city => city, :given_province => province, :given_country => country, :search_keyword => keyword, :result_userEmail => {display_photo: user_avatar, result: search_byUserEmail, borrowRate: search_byUserEmail_borrowRate, lendRate: search_byUserEmail_lendRate}, :result_itemISBN => search_byISBN, :result_itemNameBrand => search_byItemNameAndBrand, :corrected_keyword => correction_result, :result_correctedKeyword => search_byCorrection, :search_byISBN_requestsCount => search_byISBN_history, :search_byNameBrand_requestsCount => search_byItemNameAndBrand_history, :search_byCorrection_requestsCount => search_byCorrection_history}
	end
end
