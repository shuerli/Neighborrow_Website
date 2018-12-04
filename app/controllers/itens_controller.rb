class ItensController < ApplicationController
    def new
    end
    def edit
    end
    def create
    end
    def update
    end
    
    def show
        @item = Iten.find(params[:id])
    end
    
    def index
        @item_ids = []
        @categories = Category.where(:department => params[:department])
        @categories.each do |cat|
            puts cat.id
            @item_ids << Iten.where(:category_id => cat.id).map(&:id)
        end
        

    end
    
    def destroy
        @item = Itens.find(params[])
        @item.update(params.require(:item).permit(:status))
	end
	
	def keyword_prompt
		#search_result = ActiveRecord::Base.connection.exec_query("SELECT name FROM Itens WHERE name LIKE '"+params[:input]+"%' ")
		search_result = Iten.where("name like ?", params[:input]+"%")
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
		# Case 1: Keyword of Itens (id, name, brand, 10-digit or 13-digit isbn)
		# Case 2: Keyword of Users (display_name, email)
		# Case 3: Keyword of Locations (current_city)

		############################ User Check ##################################
		# Situation 1: Email
		# Situation 2: Display_name
		email_check = (keyword =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
		user_avatar = nil
		if(email_check == 0)
			search_byUserEmail = ActiveRecord::Base.connection.exec_query("SELECT Accounts.id, display_name, gender, language, country, avatar_url FROM Accounts, Profiles WHERE Accounts.email = Profiles.email AND Profiles.email = '"+keyword+"';")
			search_byUserEmail_borrowRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_borrowers.rate) AS \"borrow_rate\" FROM feedback_to_borrowers, requests WHERE requests.borrower = '"+keyword+"' AND feedback_to_borrowers.request_id = requests.id;")
			search_byUserEmail_lendRate = ActiveRecord::Base.connection.exec_query("SELECT AVG(feedback_to_lenders.rate) AS \"lend_rate\" FROM feedback_to_lenders, requests, items WHERE items.owner = '"+keyword+"' AND feedback_to_lenders.request_id = requests.id AND requests.item_id = items.id;")
			@profile = Profile.find_by_email(keyword)
			if(@profile)
				user_avatar = url_for(@profile.avatar)
			end
		end
		#search_byUserName = ActiveRecord::Base.connection.exec_query("SELECT email, display_name, gender, language, country, avatar_url FROM Profiles WHERE display_name = '"+keyword+"';")
		############################ Itens Check ##################################
		# Situation 1: ISBN
		if(keyword.to_i.to_s == keyword && (keyword.length==13 || keyword.length==10))
			search_byISBN = ActiveRecord::Base.connection.exec_query("SELECT Pickupaddresses.postal_code AS \"postcode\", Profiles.avatar_url AS \"ownerPhoto\", Itens.condition AS \"itemCondition\", Itens.id AS \"itemID\", Itens.name, Itens.rate_level AS \"minRate\", Itens.photo_url AS \"itemPhoto\", Profiles.display_name AS \"ownerName\", Accounts.id AS \"ownerID\" FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND Itens.isbn = '"+keyword.to_i+"';")
			search_byISBN_history = ActiveRecord::Base.connection.exec_query("SELECT Itens.id AS \"itemID\", COUNT(*) AS \"count\" FROM Requests, Itens, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Requests.item_id = Itens.id AND Itens.isbn = '"+keyword.to_i+"' GROUP BY Itens.id;")
			search_byISBN_lenderEmail = ActiveRecord::Base.connection.exec_query("SELECT Profiles.email, Accounts.id FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND Itens.isbn = '"+keyword.to_i+"';")
			search_byISBN_lenderAvatar = Hash.new
			search_byISBN_lenderAVG = Hash.new
			search_byISBN_lenderEmail.each { |x|
				search_byISBN_lenderAvatar[x["id"]] = url_for(Profile.find_by_email(x["email"]).avatar)
				temp = ActiveRecord::Base.connection.exec_query("SELECT Itens.owner, AVG(Feedback_to_lenders.rate) AS \"average\" FROM Feedback_to_lenders, Requests, Itens WHERE Feedback_to_lenders.request_id = Requests.id AND Requests.item_id = Itens.id AND Itens.owner = '"+x["email"]+"';")
				
				if(temp.length > 0)
					search_byISBN_lenderAVG[x["id"]] = temp[0]["average"]
				else
					search_byISBN_lenderAVG[x["id"]] = "-"
				end
			}
		end

		# Situation 2: Id (Abandoned)
		#if(keyword.to_i.to_s == keyword)
		#	search_byItenID = ActiveRecord::Base.connection.exec_query("SELECT Profiles.avatar_url AS ownerPhoto, Itens.condition AS itemCondition, Itens.id AS itemID, Itens.name, Itens.rate_level AS minRate, Itens.photo_url AS itemPhoto, Profiles.display_name AS ownerName, Accounts.id AS ownerID FROM Itens, Profiles, Accounts WHERE Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND Itens.id = "+keyword.to_i+";")
		#end

		# Situation 3: Name & Brand
		search_byItemNameAndBrand = ActiveRecord::Base.connection.exec_query("SELECT Pickupaddresses.postal_code AS \"postcode\", Profiles.email, Profiles.avatar_url AS \"ownerPhoto\", Itens.condition AS \"itemCondition\", Itens.id AS \"itemID\", Itens.name, Itens.rate_level AS \"minRate\", Itens.photo_url AS \"itemPhoto\", Profiles.display_name AS \"ownerName\", Accounts.id AS \"ownerID\" FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND (LOWER(Itens.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Itens.brand) = LOWER('%"+keyword+"%'));")
		search_byItemNameAndBrand_history = ActiveRecord::Base.connection.exec_query("SELECT Itens.id AS \"itemID\", COUNT(*) AS \"count\" FROM Requests, Itens, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Requests.item_id = Itens.id AND (LOWER(Itens.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Itens.brand) = LOWER('%"+keyword+"%')) GROUP BY Itens.id;")
		search_byItemNameAndBrand_lenderEmail = ActiveRecord::Base.connection.exec_query("SELECT Profiles.email, Accounts.id FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND (LOWER(Itens.name) LIKE LOWER('%"+keyword+"%') OR LOWER(Itens.brand) = LOWER('%"+keyword+"%'));")
		search_byItemNameAndBrand_lenderAvatar = Hash.new
		search_byItemNameAndBrand_lenderAVG = Hash.new
		search_byItemNameAndBrand_lenderEmail.each { |x|
			search_byItemNameAndBrand_lenderAvatar[x["id"]] = url_for(Profile.find_by_email(x["email"]).avatar)
			temp = ActiveRecord::Base.connection.exec_query("SELECT Itens.owner, AVG(Feedback_to_lenders.rate) AS \"average\" FROM Feedback_to_lenders, Requests, Itens WHERE Feedback_to_lenders.request_id = Requests.id AND Requests.item_id = Itens.id AND Itens.owner = '"+x["email"]+"' GROUP BY Itens.owner;")
			if(temp.length>0)
				search_byItemNameAndBrand_lenderAVG[x["id"]] = temp[0]["average"]
			else
				search_byItemNameAndBrand_lenderAVG[x["id"]] = "-"
			end
				

		}
		
		if(:search_byItemNameAndBrand.size==0)
			require 'gingerice'
			parser = Gingerice::Parser.new
			correction = parser.parse(keyword)
			correction_result = correction["result"].downcase
			search_byCorrection = ActiveRecord::Base.connection.exec_query("SELECT Pickupaddresses.postal_code AS \"postcode\", Profiles.avatar_url AS \"ownerPhoto\", Itens.condition AS \"itemCondition\", Itens.id AS \"itemID\", Itens.name, Itens.rate_level AS \"minRate\", Itens.photo_url AS \"itemPhoto\", Profiles.display_name AS \"ownerName\", Accounts.id AS \"ownerID\" FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND (LOWER(Itens.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Itens.brand) = LOWER('%"+correction_result+"%'));")
			search_byCorrection_history = ActiveRecord::Base.connection.exec_query("SELECT Itens.id AS \"itemID\", COUNT(*) AS \"count\" FROM Requests, Itens, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Requests.item_id = Itens.id AND (LOWER(Itens.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Itens.brand) = LOWER('%"+correction_result+"%')) GROUP BY Itens.id;")
			search_byCorrection_lenderEmail = ActiveRecord::Base.connection.exec_query("SELECT Profiles.email, Accounts.id FROM Itens, Profiles, Accounts, Pickupaddresses WHERE Itens.address = Pickupaddresses.id AND Pickupaddresses.city = '"+city+"' AND Pickupaddresses.province = '"+province+"' AND Pickupaddresses.country = '"+country+"' AND Accounts.email = Profiles.email AND Itens.owner = Profiles.email AND (LOWER(Itens.name) LIKE LOWER('%"+correction_result+"%') OR LOWER(Itens.brand) = LOWER('%"+correction_result+"%'));")
			search_byCorrection_lenderAvatar = Hash.new
			search_byCorrection_lenderAVG = Hash.new
			search_byCorrection_lenderEmail.each { |x|
				search_byCorrection_lenderAvatar[x["id"]] = url_for(Profile.find_by_email(x["email"]).avatar)
				temp = ActiveRecord::Base.connection.exec_query("SELECT Itens.owner, AVG(Feedback_to_lenders.rate) AS \"average\" FROM Feedback_to_lenders, Requests, Itens WHERE Feedback_to_lenders.request_id = Requests.id AND Requests.item_id = Itens.id AND Itens.owner = '"+x["email"]+"' GROUP BY Itens.owner;")
				
				if(temp.length>0)
					search_byCorrection_lenderAVG[x["id"]] = temp[0]["average"]
				else
					search_byCorrection_lenderAVG[x["id"]] = "-"
				end
			}
		end
		
		render :json => {:status => 200, :given_city => city, :given_province => province, :given_country => country, :search_keyword => keyword, :result_userEmail => {display_photo: user_avatar, result: search_byUserEmail, borrowRate: search_byUserEmail_borrowRate, lendRate: search_byUserEmail_lendRate}, :result_itemISBN => search_byISBN, :result_itemNameBrand => search_byItemNameAndBrand, :corrected_keyword => correction_result, :result_correctedKeyword => search_byCorrection, :search_byISBN_requestsCount => search_byISBN_history, :search_byNameBrand_requestsCount => search_byItemNameAndBrand_history, :search_byCorrection_requestsCount => search_byCorrection_history, :search_byISBN_lenderPhoto => search_byISBN_lenderAvatar, :search_byItemNameAndBrand_lenderPhoto => search_byItemNameAndBrand_lenderAvatar, :search_byCorrection_lenderPhoto => search_byCorrection_lenderAvatar, :search_byItemNameAndBrand_lenderRate => search_byItemNameAndBrand_lenderAVG, :search_byISBN_lenderRate => search_byISBN_lenderAVG, :search_byCorrection_lenderRate => search_byCorrection_lenderAVG}
	end

	def unavailable_time
		@item = params[:itemId]
		@unavailable_time =  ActiveRecord::Base.connection.exec_query("SELECT time_start, time_end from Requests WHERE \'#{@item}\' = item_id AND status = \'accepted\'")
		render :json => @unavailable_time
	end
end
