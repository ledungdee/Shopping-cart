class ProductsController < ApplicationController
    def new
        @product = current_shop.products.build 
    end

    def create
        if params[:product][:size_M] =='1'
            @product = current_shop.products.build(product_params)
            @quantity = params[:product][:Quantity_M]
            if  @product.save
                @product.update(size: "M", quantity_remain: @quantity)
                @x = 1
            end
       end 

       if params[:product][:size_L] =='1'
            @product = current_shop.products.build(product_params)
            @quantity = params[:product][:Quantity_L]
            if  @product.save
                @product.update(size: "L", quantity_remain: @quantity)
                @y = 1
            end
        end

        if params[:product][:size_XL] =='1'
            @product = current_shop.products.build(product_params)
            @quantity = params[:product][:Quantity_XL]
            if  @product.save
                @product.update(size: "XL", quantity_remain: @quantity)
                @z = 1
            end
       end
       if @x == 1 || @y== 1 || @z ==1
            flash[:success] = "Success!" 
            redirect_to root_url
        else
            render 'new', status: :unprocessable_entity
        end
   end                

    def index
        @products = Product.all
    end
    
    def show 
        @product = Product.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end


    private
    def product_params
        params.require(:product).permit(:shop_id, :name, :color, :size, :price, :quantity_remain, :description)
    end
    
end
