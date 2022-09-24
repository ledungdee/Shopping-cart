class Product < ApplicationRecord

    belongs_to :shop 
    validates :name,  presence: true, length: { maximum: 50 } 
end
