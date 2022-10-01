module ProductsHelper

    def current_product
        @current_product = Product.find($id_current_product)
    end

    def maxquantity(id,size)
        @product = Product.find_by(id: id)
        case size
        when 's' then return @product.size_s
        when 'm' then return @product.size_m
        when 'l' then return @product.size_l
        else 
            return @product.size_xl 
        end
    end

    def status
        if (current_product.size_s + current_product.size_m + current_product.size_l + current_product.size_xl) > 0
            return 1
        else
            return 0
        end
    end   
end
