class UserItemsController < ApplicationController
    layout false
    def show_all
    end
    def get_data_all
        # if !current_user
		# 	render :json => {:status => 403}
        # end
       
       
       # REMOVE TESTING USER
        user = 'raymondfzy@gmail.com'

        case params[:type]     
        when 'lent'
            #! CHANGE CURRENT_USER TO CURRENT_USER.EMAIL
            lent_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user}' AND Items.status = 'lent' ORDER BY Items.created_at;")
            render :json => {:status => 200, :result => lent_items}

        when 'registered'
            registered_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user}' AND Items.status = 'registered' ORDER BY Items.created_at;")
            render :json => {:status => 200, :result => registered_items}
        else
            render :json => {:status => 404}
        end
    end
  

    def show
    end
    def get_data
        # if !current_user
		# 	render :json => {:status => 403}
        # end

        @user_item = Item.find( params[:id])
        if not @user_item.status == 'disabled'
            render :json => {:status => 200, :result => @user_item}
        else
            render :json => {:status => 404}
        end
    end

    
    

    def destroy
        # if !current_user
		# 	render :json => {:status => 403}
        # end

        @user_item = Item.find(params[:id])
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
    end
    
    def create
        # if !current_user
		# 	render :json => {:status => 403}
        # end

        @user_item = Item.new

        # # @user_item.owner = current_user.email
        @user_item.owner = "raymondfzy@gmail.com"
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

        if @user_item.save
             render :json => {:status => 200}
        else 
             render :json => {:status => 404}
        end
    end

    def edit
    end

    def update
        # if !current_user
		# 	render :json => {:status => 403}
        # end

        @user_item = Item.find(params[:id])

        @user_item.condition = params[:condition]
        @user_item.time_start = params[:time_start]
        @user_item.time_end = params[:time_end]
        @user_item.name = params[:name]
        @user_item.description = params[:description]
        @user_item.brand = params[:brand]
        @user_item.category_id = params[:category_id]
        @user_item.photo_url = params[:photo_url]
        
        @user_item.address = params[:address]

        if @user_item.save
             render :json => {:status => 200}
        else 
             render :json => {:status => 404}
        end
    end

    def get_address
        @address = Address.find(params[:add])
        render :json => {:status => 200, :result => @address}
    end

    def add_address
        @address = Address.new
        @address.email = 'raymondfzy@gmail.com'

        #@address.email = current_user.email
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
end
