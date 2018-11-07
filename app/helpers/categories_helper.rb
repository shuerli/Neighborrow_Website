module CategoriesHelper
    
    # Returns the list of categories
    def categories
        @categories = Category.all
    end
    
end
