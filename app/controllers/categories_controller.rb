class CategoriesController < ApplicationController
    def index
    end
    
    def show
        @category = Category.find(params[:id])
        render :json => {:status => 200, :result => @category}
    end

    def index
        @category = Category.all
        render :json => {:status => 200, :result => @category}
    end
    
    def departments
        departments = ActiveRecord::Base.connection.exec_query("SELECT DISTINCT department FROM Categories")
        render :json => {:status => 200, :result => departments} 
    end
end
