class AccountsController < ApplicationController
    def create
        render plain: params[:account].inspect
    end
    
    def index
    end
    
    def new
        
    end
    
end
