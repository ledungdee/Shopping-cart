module CartSessionsHelper

    def current_cart_session
        current_user.cart_session
    end
end
