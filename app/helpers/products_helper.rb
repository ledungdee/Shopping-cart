module ProductsHelper

    def current_product
        @current_product = Product.find($id_current_product)
    end 
end
