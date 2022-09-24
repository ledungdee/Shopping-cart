class CartItem < ApplicationRecord
    belongs_to :products
    belongs_to :cart_session 
end
