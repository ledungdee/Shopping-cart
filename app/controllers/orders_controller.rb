class OrdersController < ApplicationController
    def index
        @orders = current_user.orders
    end
    def show
        @order = Order.find_by(id:params[:id])
        @order_items = @order.order_items
    end
end
