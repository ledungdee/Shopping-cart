class CartSession < ApplicationRecord
    belongs_to :user
    has_many :Cart_items
    
end
