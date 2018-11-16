class UserItemsController < ApplicationController
    def index
    end
  
    def show
      user_email = 'raymondfzy@gmail.com'
      case params[:type]
      when 'lent'
          lent_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user_email}' AND Items.status = 'lent' ORDER BY Items.time_start;")
          render :json => {:status => 200, :result => lent_items}

      when 'registered'
          registered_items = ActiveRecord::Base.connection.exec_query("SELECT * FROM Items WHERE Items.owner = '#{user_email}' AND Items.status = 'registered' ORDER BY Items.time_start;")
          render :json => {:status => 200, :result => registered_items}
      else
        render :json => {:status => 404}
      end
    end


end
