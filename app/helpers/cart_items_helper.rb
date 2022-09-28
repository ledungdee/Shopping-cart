module CartItemsHelper
    def current_cart_items
        current_cart_session.cart_items
    end
    def cart_item_destroy
       CartItem.find(params[:id])
    end
end
