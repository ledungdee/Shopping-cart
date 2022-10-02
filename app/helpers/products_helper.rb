module ProductsHelper

    def current_product
        @current_product = Product.find($id_current_product)
    end


    def status
        if (current_product.size_s.to_i + current_product.size_m.to_i + current_product.size_l.to_i + current_product.size_xl.to_i) > 0
            return 1
        else
            return 0
        end
    end  
    def max_quantity(id,size)
        @product = Product.find_by(id: id)
        case size
        when 'S' then return @product.size_s
        when 'M' then return @product.size_m
        when 'L' then return @product.size_l
        else 
            return @product.size_xl 
        end
      end 
end
