module ProductsHelper

    def current_product
        @current_product = Product.find($id_current_product)
    end


    def status
        if (current_product.size_s + current_product.size_m + current_product.size_l + current_product.size_xl) > 0
            return 1
        else
            return 0
        end
    end   
end
