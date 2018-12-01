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
    
    def by_department
        selectedDepartment = params[:department]
        category_names = ActiveRecord::Base.connection.exec_query("SELECT name FROM Categories WHERE department =\'#{selectedDepartment}\'")
        render :json => {:status => 200, :result => category_names} 
    end

    def find_id
        inputDepartment = params[:department]
        inputCategory = params[:category]
        category_id = ActiveRecord::Base.connection.exec_query("SELECT id FROM Categories WHERE department =\'#{inputDepartment}\' AND name = \'#{inputCategory}\'")
        render :json => {:status => 200, :result => category_id} 
    end
end

