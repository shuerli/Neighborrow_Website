class UserItemsController < ApplicationController
    layout false
    def show_all
        if !current_user
			redirect_to "/login"
        end
    end
    def get_data_all
        if !current_user
			redirect_to "/login"
        end
       
    
        user = current_user.email
        case params[:type]     
        when 'lent'
           
            lent_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Itens WHERE Itens.owner = '#{user}' AND Itens.status = 'lent' ORDER BY Itens.created_at;")
            render :json => {:status => 200, :result => lent_items}

        when 'registered'
            registered_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Itens WHERE Itens.owner = '#{user}' AND Itens.status = 'registered' ORDER BY Itens.created_at;")
            render :json => {:status => 200, :result => registered_items}
        else
            render :json => {:status => 404}
        end
    end
  

    def show
        if !current_user
			redirect_to "/login"
        end
    end
    def get_data
        if !current_user
			redirect_to "/login"
        end

        @user_item = Iten.find( params[:id])
        if not @user_item.status == 'disabled'
            render :json => {:status => 200, :result => @user_item}
        else
            render :json => {:status => 404}
        end
    end

    
    

    def destroy
        if !current_user
			redirect_to "/login"
        end

        @user_item = Iten.find(params[:id])
        if not @user_item.status == 'lent'
            @user_item.status = 'disabled'
            if @user_item.save
                render :json => {:status => 200}
            else
                render :json => {:status => 404}
            end
        else
            render :json => {:status => 404}
        end
    end

    def new
        if !current_user
			redirect_to "/login"
        end
    end
    
    def create
        if !current_user
			redirect_to "/login"
        end

        @user_item = Iten.new

        @user_item.owner = current_user.email
        # @user_item.owner = "raymondfzy@gmail.com"
        @user_item.status = 'registered'
        @user_item.condition = params[:condition]
        @user_item.time_start = params[:time_start]
        @user_item.time_end = params[:time_end]
        @user_item.name = params[:name]
        @user_item.description = params[:description]
        @user_item.brand = params[:brand]
        @user_item.category_id = params[:category_id]
        @user_item.photo_url = params[:photo_url]
        @user_item.address = params[:address]
        @user_item.deposit = params[:deposit]
        @user_item.rate_level = params[:rate_level]

        if @user_item.save
             render :json => {:status => 200}
        else 
             render :json => {:status => 404}
        end
    end

    def edit
        if !current_user
			redirect_to "/login"
        end
    end

    def update
        if !current_user
			redirect_to "/login"
        end

        

        @user_item = Iten.find(params[:id])

        @user_item.condition = params[:condition]
        @user_item.time_start = params[:time_start]
        @user_item.time_end = params[:time_end]
        @user_item.name = params[:name]
        @user_item.description = params[:description]
        @user_item.brand = params[:brand]
        @user_item.category_id = params[:category_id]
        @user_item.address = params[:address]
        @user_item.deposit = params[:deposit]
        @user_item.rate_level = params[:rate_level]
        
        if params[:remove_photo] == 'true'
            @user_item.photo_url = nil
        end

        if params[:new_photo] == 'true' 
            @user_item.photo_url = params[:photo_url]
        end
        
        if @user_item.save
             render :json => {:status => 200}
        else 
             render :json => {:status => 404}
        end
    end

    def get_address
        @address = Pickupaddress.find(params[:add])
        render :json => {:status => 200, :result => @address}
    end

    def add_address
        @address = Pickupaddress.new

        @address.email = current_user.email
        @address.address_line1 = params[:address_line1]
        @address.city = params[:city]
        @address.province = params[:province]
        @address.country = params[:country]
        @address.postal_code =  params[:postal_code]
        if @address.save
            render :json => @address
       else 
            render :json => {:status => 404}
       end
    end

    def find_borrower
        if !current_user
			redirect_to "/login"
        end

        @borrower_email = ActiveRecord::Base.connection.exec_query("SELECT borrower FROM Requests WHERE item_id = \'#{params[:itemId]}\' AND status = \'accepted\'")
        @borrower = @borrower_email[0]
        render :json => @borrower
    end
end
