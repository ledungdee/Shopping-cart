class OrdersController < ApplicationController
    before_action :logged_in_user, only:[:index]
    def index
        @orders = current_user.orders
        
    end
    private
    def logged_in_user 
        if logged_in? == false 
            store_location #L10.32
            flash[:danger] ="Please log in." 
            redirect_to login_url, status: :see_other 
        end 
    end
end
