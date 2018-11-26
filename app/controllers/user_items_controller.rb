class UserItemsController < ApplicationController
    layout false
    def show_all
    end
    def get_data_all
        # if !current_user
		# 	render :json => {:status => 403}
        # end
        user = 'raymondfzy@gmail.com'

        case params[:type]     
        when 'lent'
            #! CHANGE CURRENT_USER TO CURRENT_USER.EMAIL
            lent_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user}' AND Items.status = 'lent' ORDER BY Items.time_start;")
            render :json => {:status => 200, :result => lent_items}

        when 'registered'
            registered_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user}' AND Items.status = 'registered' ORDER BY Items.time_start;")
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
        
        # how to pass in user id to user_item_params?
        @user_item = Item.new(user_item_params)
        if @user_item.save
            render :json => {:status => 200}
        else 
            render :json => {:status => 404}
        end
    end

    def edit
    end

    private def user_item_params
        params.require(:item).permit(:owner, :status, :category_id, :condition, :time_start, :time_end, :name, :photo_url, :description, :brand)
    end
end
