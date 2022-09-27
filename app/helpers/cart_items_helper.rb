module CartItemsHelper
    def current_cart_items
        current_cart_session.cart_items
    end
    def current_cart_item
        CartItem.find(params[:id])
    end
end
