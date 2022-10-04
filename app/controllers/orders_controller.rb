class OrdersController < ApplicationController
    before_action :logged_in_user, only:[:index]
    def index
        @orders = current_user.orders
    end
    def destroy
        @order = Order.find_by(id: params[:id])
        @order_items = @order.order_items
        @order_items.each do |order_item|
            @product = Product.find_by(id: order_item.product_id)
            @size = order_item.size
            @quantity = order_item.quantity
            return_quantity(@product,@size,@quantity)
            order_item.destroy
            
        end
        @order.destroy
        flash[:success] = 'Your order have been cancel'
        redirect_to orders_path, status: :see_other
    end

    private
    def logged_in_user 
        if logged_in? == false 
            store_location #L10.32
            flash[:danger] ="Please log in." 
            redirect_to login_url, status: :see_other 
        end 
    end

    def return_quantity(product,size,quantity)
        @size_s = product.size_s + quantity
        @size_m = product.size_m + quantity
        @size_l = product.size_l + quantity
        @size_xl = product.size_xl + quantity
        case size
        when 'S' then product.update_attribute(:size_s, @size_s)
        when 'M' then product.update_attribute(:size_m, @size_m)
        when 'L' then product.update_attribute(:size_l, @size_l)
        when 'XL' then product.update_attribute(:size_xl, @size_xl)
        end
    end
end
