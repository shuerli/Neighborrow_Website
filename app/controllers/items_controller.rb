class ItemsController < ApplicationController
    def new
    end
    def edit
    end
    def create
    end
    def update
    end
    
    def destroy
        @item = Items.find(params[])
        @item.update(params.require(:item).permit(:status))
    end
end
